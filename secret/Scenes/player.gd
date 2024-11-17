extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0


@export var can_move=true

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if can_move:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if !is_on_floor():
			animation_player.play("jump")
			
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
