extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var idle_timer: Timer = $Idle_timer
@onready var collision_shape_2d: CollisionShape2D = $Detection/CollisionShape2D
@export var patrol_range := 120
@export var speed = 100
@export var my_parent:Node2D
var direction := 1
var is_idling := false
var start_position: float
var triggered:=false
var move_direction
var position_for_player:Vector2
func _ready() -> void:
	direction = 1
	sprite_2d.flip_h = false
	start_position = global_position.x

func _physics_process(delta: float) -> void:
	if not is_idling and not triggered:
		var distance_from_start = global_position.x - start_position
		
		# Check boundaries without teleporting
		if (direction == 1 and distance_from_start >= patrol_range) or \
		   (direction == -1 and distance_from_start <= -patrol_range):
			velocity.x = 0
			is_idling = true
			direction *= -1
			animation_player.play("Idle")
			idle_timer.start(randf_range(0,2))
		else:
			animation_player.play("move")
			velocity.x = direction * speed
			sprite_2d.flip_h = (direction == -1)
			collision_shape_2d.position.x=32 if direction==1 else -32
			
	if triggered and abs(position.x-position_for_player.x)-5>0 :
		print("i see the player")
		# Determine movement direction towards player's position
		
		velocity.x = move_direction * speed
		sprite_2d.flip_h = (move_direction < 0)
	elif triggered:
		velocity.x=0
	move_and_slide()

func _on_idle_timer_timeout() -> void:
	is_idling = false
	

func _on_detection_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("Player"):
		triggered=true
		area.get_parent().can_move=false
		animation_player.play("Triggered")
		position_for_player=area.get_parent().position
		print(position_for_player)
		my_parent.death_animation()
		move_direction = sign(position_for_player.x - position.x)
