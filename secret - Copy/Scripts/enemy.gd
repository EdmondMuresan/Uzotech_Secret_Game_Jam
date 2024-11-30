extends Node2D

const SPEED = 60

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var rat_attack: AudioStreamPlayer = $rat_attack


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


func _on_killzone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var my_parent=get_parent()
		rat_attack.play()
		my_parent.death_animation()
