extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

var near_ladder:=false

@export var can_move=true

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var visible_for_wolf: Area2D = $VisibleForWolf
@onready var eye_closed: Sprite2D = $Eye_Closed
@onready var dust: CPUParticles2D = $CPUParticles2D


func _physics_process(delta: float) -> void:
	if not is_on_floor() and !near_ladder:
		velocity += get_gravity() * delta
	if can_move:
		if Input.is_action_just_pressed("jump") and is_on_floor() and !near_ladder:
			velocity.y = JUMP_VELOCITY
		if !is_on_floor():
			animation_player.play("jump")
			
		var direction := Input.get_axis("left", "right")
		
		if direction>0:
			sprite_2d.flip_h=false
		elif direction<0:
			sprite_2d.flip_h=true
			
		if direction:
			dust.emitting=true
			dust.gravity=Vector2(400*direction	,0)
			animation_player.play("run")
			
			velocity.x = direction * SPEED
		else:
			dust.emitting=false
			animation_player.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
		
		if near_ladder:
			var ladder_direction= Input.get_axis("up","down")
			if ladder_direction:
				velocity.y=ladder_direction*SPEED
		
	else:
		animation_player.play("RESET")
	
	move_and_slide()

func _on_surrounding_detector_body_exited(body: Node2D) -> void:
	if body.is_in_group("Ladder"):
		print("I am no longer near a ladder")
		near_ladder=false
func _on_surrounding_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ladder"):
		print("I am near a ladder")
		near_ladder=true


func _on_surrounding_detector_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("Bush"):
		print("I am in the bush")
		visible_for_wolf.set_deferred("monitorable",false)
		eye_closed.visible=true

func _on_surrounding_detector_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("Bush"):
		print("I am not in the bush")
		visible_for_wolf.set_deferred("monitorable",true)
		eye_closed.visible=false
