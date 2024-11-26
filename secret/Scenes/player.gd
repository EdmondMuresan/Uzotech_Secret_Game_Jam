extends CharacterBody2D

@export var CAYOTE = 0.1
@export var SPEED = 150.0
@export var JUMP_VELOCITY = -300.0

var near_ladder:=false

@export var can_move=true
var since_on_floor=0
var recently_jumped=false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:

	if not is_on_floor() and !near_ladder:
		velocity += get_gravity() * delta
	if can_move:
		if Input.is_action_just_pressed("jump") and is_on_floor() and !near_ladder:

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
	
		
		if near_ladder:
			var ladder_direction= Input.get_axis("up","down")
			if ladder_direction:
				velocity.y=ladder_direction*SPEED
		move_and_slide()
	else:
		animation_player.play("RESET")
	


func _on_surrounding_detector_body_exited(body: Node2D) -> void:
	if body.is_in_group("Ladder"):
		print("I am no longer near a ladder")
		near_ladder=false
	if body.is_in_group("Bush"):
		print("I am not near a bush")
func _on_surrounding_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ladder"):
		print("I am near a ladder")
		near_ladder=true
	if body.is_in_group("Bush"):
		print("I am near a bush")
