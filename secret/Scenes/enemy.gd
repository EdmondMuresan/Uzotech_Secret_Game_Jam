extends Node2D

const SPEED = 60

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction = 1

func turn():
	direction *= -1
	sprite.flip_h = not sprite.flip_h

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ray
	if direction == -1:
		ray = ray_cast_left
	else:
		ray = ray_cast_right
	if ray.is_colliding():
		turn()
	
	position.x += direction*SPEED*delta
