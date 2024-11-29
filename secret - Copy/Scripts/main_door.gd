extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $Lock/AnimatedSprite2D
@onready var control: Control = $Camera2D/Control
@export var player: CharacterBody2D

var init=false
var near=false
func _ready() -> void:
	animated_sprite_2d.visible=false
	control.visible=false
	print("The global code is the following: "+ str(Global.code))
func _on_lock_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animated_sprite_2d.visible = true
		print("Player entered the lock area.")
		near=true
func _on_lock_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animated_sprite_2d.visible=false
		near=false
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("lock") and near:
			print("Action button pressed!")  # Debugging to confirm input detection
			if init == false:
				init = true
				control.visible = true
				player.can_move=false
				print("Control made visible.")  # Debugging
			elif init == true:
				init = false
				player.can_move=true
				control.visible = false
				print("Control hidden.")
