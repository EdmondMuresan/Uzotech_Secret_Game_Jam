extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var idle_timer: Timer = $Idle_timer
@onready var collision_shape_2d: CollisionShape2D = $Detection/CollisionShape2D
@export var patrol_range := 120
@export var speed = 100

var direction := 1
var is_idling := false
var start_position: float
var triggered:=false
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
			animation_player.play("Idle")
			idle_timer.start(randf_range(0,2))
		else:
			animation_player.play("move")
			velocity.x = direction * speed
			sprite_2d.flip_h = (direction == -1)
			collision_shape_2d.position.x=32 if direction==1 else -32
			
	
	move_and_slide()

func _on_idle_timer_timeout() -> void:
	is_idling = false
	direction *= -1


func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		triggered=true
		body.can_move=false
		animation_player.play("Triggered")
		if is_idling:
			velocity.x = direction * speed
		var parent=get_parent()
		parent.death_animation()
		body.queue_free()


func _on_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		triggered=false
