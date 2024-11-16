extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if !is_on_floor():
		animation_player.play("jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
		
	if direction>0:
		sprite_2d.flip_h=false
	elif direction<0:
		sprite_2d.flip_h=true
	if direction:
		animation_player.play("run")
		velocity.x = direction * SPEED
	else:
		animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
