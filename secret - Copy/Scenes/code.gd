extends Node2D

@onready var code_tiles_parent = $"Frame/Code"
@onready var full_symbol = $"FullSymbol"
@onready var tile_moved_sound = $"Frame/StoneBlockMoved"
@onready var timer = $"Timer"

var symbol_number = 0
var num_segments = Vector2i(3, 3)
var skip_segment = Vector2i(0, 0)
var solution = [null, 0, 1, 2, 3, 4, 5, 6, 7]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_code_tiles()

func setup_code_tiles():
	var texture: Texture2D = load("res://Sprites/symbols/0.png")
	var s = Vector2i(texture.get_size())
	var seg_s = s / num_segments
	
	var coll_rect = RectangleShape2D.new()
	coll_rect.size = seg_s
	
	# set code tiles manager stuff
	code_tiles_parent.solution = solution
	code_tiles_parent.sprites_per_row = 3
	code_tiles_parent.sprite_size = seg_s
	
	# set an offset to center tiles
	code_tiles_parent.position = -s / 2
	
	for seg_x in num_segments.x:
		for seg_y in num_segments.y:
			if Vector2i(seg_x, seg_y) == skip_segment:
				continue
			
			var area2d = Area2D.new()
			area2d.name = "%d_%d".format([seg_x, seg_y])
			code_tiles_parent.add_child(area2d)
			
			# NOTE: sprites are not centered, and that's why we have to offset shapes
			var collision_shape = CollisionShape2D.new()
			collision_shape.position = seg_s / 2
			collision_shape.shape = coll_rect
			area2d.add_child(collision_shape)
			
			var sprite_2d = Sprite2D.new()
			sprite_2d.texture = texture
			sprite_2d.region_enabled = true
			sprite_2d.centered = false
			
			var seg_start = Vector2(seg_x, seg_y) * Vector2(seg_s)
			sprite_2d.region_rect = Rect2(seg_start, seg_s)
			
			area2d.add_child(sprite_2d)
	
	code_tiles_parent.start()
	
	full_symbol.texture = texture
	code_tiles_parent.connect("solved", puzzle_solved)
	
	timer.connect("timeout", func(): tile_moved_sound.stop())
	code_tiles_parent.connect("tile_moved", play_sound)

func play_sound():
	timer.start()
	tile_moved_sound.play()

func puzzle_solved():
	full_symbol.visible = true
	code_tiles_parent.visible = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
