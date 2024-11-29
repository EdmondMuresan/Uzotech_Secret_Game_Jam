extends Node
@onready var _1: Sprite2D = $"1"
@onready var _2: Sprite2D = $"2"
@onready var _3: Sprite2D = $"3"
@onready var _4: Sprite2D = $"4"
@onready var _5: Sprite2D = $"5"
@onready var _6: Sprite2D = $"6"
const _s0 = preload("res://Sprites/symbols/0.png")
const _s1 = preload("res://Sprites/symbols/1.png")
const _s2 = preload("res://Sprites/symbols/2.png")
const _s3 = preload("res://Sprites/symbols/3.png")
const _s4 = preload("res://Sprites/symbols/4.png")
const _s5 = preload("res://Sprites/symbols/5.png")
const _s6 = preload("res://Sprites/symbols/6.png")
const _s7 = preload("res://Sprites/symbols/7.png")
const _s8 = preload("res://Sprites/symbols/8.png")
const _s9 = preload("res://Sprites/symbols/9.png")

var symbols = []
var tiles = []
var code
var deleted
var positions_for_tiles = {}
var position_and_tile_name = {}
var matrix_of_movement=[1,1,1,1,1,1,1]
func _ready() -> void:
	code = Global.code % 10
	tiles.append(_1)
	tiles.append(_2)
	tiles.append(_3)
	tiles.append(_4)
	tiles.append(_5)
	tiles.append(_6)
	
	symbols.append(_s0)
	symbols.append(_s1)
	symbols.append(_s2)
	symbols.append(_s3)
	symbols.append(_s4)
	symbols.append(_s5)
	symbols.append(_s6)
	symbols.append(_s7)
	symbols.append(_s8)
	symbols.append(_s9)
	
	for image in tiles:
		var pos = Vector2(image.position.x, image.position.y)
		position_and_tile_name[image.name] = pos
		positions_for_tiles[pos] = image.name
		image.initial_position=pos
		image.texture = symbols[code-1]
		print(pos)
	deleted = tiles.pick_random()
	matrix_of_movement[deleted.my_name-1]=0
	var deleted_position = deleted.position
	
	positions_for_tiles.erase(deleted_position)
	print(deleted.name + " is deleted")
	deleted.queue_free()
	
	for image in tiles:
		if image != deleted:
			var new_position = positions_for_tiles.keys().pick_random()
			image.position = new_position
			positions_for_tiles.erase(new_position)
			print(position_and_tile_name[image.name])
			print(image.name)
	for image in tiles:
		image.tile_moved.connect(_on_tile_moved)
		
func _on_tile_moved(tile_name: int, direction: String) -> void:
	# Update the matrix of movement based on the tile's movement
	match direction:
		"left":
			matrix_of_movement[tile_name - 1 + 1] = 0  # Block right movement of next tile
		"right":
			matrix_of_movement[tile_name - 1 - 1] = 0  # Block left movement of previous tile
		"up":
			matrix_of_movement[tile_name - 1 + 3] = 0  # Block down movement below
		"down":
			matrix_of_movement[tile_name - 1 - 3] = 0  # Block up movement above
	for tile in tiles:
		if tile.my_name != tile_name:
			tile.movement_matrix = matrix_of_movement.slice(tile.my_name - 1, tile.my_name + 3)
