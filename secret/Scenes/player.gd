extends CharacterBody2D

@export var CAYOTE = 0.1
@export var SPEED = 150.0
@export var JUMP_VELOCITY = -300.0


@export var can_move=true
var since_on_floor=0
var recently_jumped=false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	if is_on_floor():
		since_on_floor = 0
		recently_jumped=false
	var was_on_floor = since_on_floor < CAYOTE
	since_on_floor += delta
	
	if not was_on_floor:
		velocity += get_gravity() * delta
	if can_move:
		if Input.is_action_just_pressed("jump") and was_on_floor and not recently_jumped:
			velocity.y = JUMP_VELOCITY
			recently_jumped = true
			print("jump")
		if !was_on_floor:
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
