extends Sprite2D
@export var my_name: int
@export var initial_position: Vector2
@export var movement_matrix: Array[int] = [1, 1, 1, 1]  # [Left, Right, Up, Down]
var _dragging: bool = false
var _drag_start: Vector2
var _movement_step: float = 64.0
var _mouse_over: bool = false
@onready var area_2d: Area2D = $Area2D

signal tile_moved(tile_name, direction)

func _ready() -> void:
	initial_position = position
	
	area_2d.mouse_entered.connect(_on_area_2d_mouse_entered)
	area_2d.mouse_exited.connect(_on_area_2d_mouse_exited)

func _on_area_2d_mouse_entered() -> void:
	scale = Vector2(1.1, 1.1)
	_mouse_over = true

func _on_area_2d_mouse_exited() -> void:
	scale = Vector2(1, 1)
	_mouse_over = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and _mouse_over:
			_dragging = true
			_drag_start = event.position
		elif not event.pressed and _dragging:
			_handle_drag(event.position)
			_dragging = false

func _handle_drag(end_pos: Vector2) -> void:
	var drag_vector = end_pos - _drag_start
	var direction = ""
	
	# Determine primary drag direction
	if abs(drag_vector.x) > abs(drag_vector.y):
		# Horizontal drag
		if drag_vector.x > 0 and movement_matrix[1] == 1:  # Right
			position.x += _movement_step
			direction = "right"
		elif drag_vector.x < 0 and movement_matrix[0] == 1:  # Left
			position.x -= _movement_step
			direction = "left"
	else:
		# Vertical drag
		if drag_vector.y > 0 and movement_matrix[3] == 1:  # Down
			position.y += _movement_step
			direction = "down"
		elif drag_vector.y < 0 and movement_matrix[2] == 1:  # Up
			position.y -= _movement_step
			direction = "up"
	
	# Emit signal if movement occurred
	if direction:
		emit_signal("tile_moved", my_name, direction)
