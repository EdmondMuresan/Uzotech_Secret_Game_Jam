extends Node2D

## called when a solution was found
## you might want to set enabled to false; to not handle any more click events
signal solved()
signal tile_moved()
signal tile_arrived()

## whether or not to handle clicks on children
@export var enabled = true
## speed of animation to new sprite position
@export var animation_speed: int = 10.0
## sprites per row in grid
@export var sprites_per_row: int
## index is spatial (a slot in the grid); null represents hole; index represents idx-th children in that slot
@export var solution: Array
## size of each sprite in world coordinates
@export var sprite_size: Vector2

# simple list of children, never changed
var children: Array[Area2D] = []

var handlers = []

# index is spatial (index corresponds with a slot on the grid)
# value is either null (hole) or index into the child index
# is copied from solution on _ready, meaning solution has to follow same rules
var current: Array = []

func get_grid_pos(index: int) -> Vector2i:
	var y = index / sprites_per_row
	var x = index % sprites_per_row
	
	return Vector2i(x, y)

func get_desired_position(index: int) -> Vector2:
	return Vector2(get_grid_pos(index)) * sprite_size

func _ready() -> void:
	start()

func start() -> void:
	enabled = true
	
	# collect children
	for child in get_children():
		if child is Area2D:
			children.append(child)
	
	if len(handlers) > 0:
		for idx in len(children):
			children[idx].disconnect("input_event", handlers[idx])
	
	handlers = []
	for idx in len(children):
		handlers.append(func(_vp, evt, _shp): child_clicked(evt, idx))
		children[idx].connect("input_event", handlers[idx])
	
	# fill current position with default values
	current = solution.duplicate()
	current.shuffle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# on every frame, move sprites towards current
	for idx in len(current):
		if current[idx] == null:
			continue
		
		# current[idx]-th child moves towards get_desired_position(idx)
		var child = children[current[idx]]
		var desired_position = get_desired_position(idx)
		child.position = child.position.lerp(desired_position, delta * animation_speed)

func child_clicked(event: InputEvent, idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		pass
	else:
		return
	
	if idx > len(children):
		return
	
	# find hole
	var hole_idx = null
	for i in len(current):
		if current[i] == null:
			hole_idx = i
			break
	
	# find child
	var child_idx = null
	for i in len(current):
		if current[i] == idx:
			child_idx = i
			break
	
	# see if our value is neighboring
	var child_pos = get_grid_pos(child_idx)
	var hole_pos = get_grid_pos(hole_idx)
	
	if abs(child_pos.distance_to(hole_pos)) - 1 > 0.01:
		return
	
	# swap indexes
	var child = current[child_idx]
	current[child_idx] = null
	current[hole_idx] = child
	
	emit_signal("tile_moved")
	
	# retarded gdscript by-value array equality test
	if current.hash() == solution.hash():
		emit_signal("solved")
