extends Node2D

@onready var timer: Timer = $Timer
@export var player:CharacterBody2D
@export var animation:TextureRect
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.visible=false
func death_animation():
	timer.start(2)
	animation.visible=true
func _on_timer_timeout() -> void:
		player.queue_free()
		get_tree().change_scene_to_file("res://Scenes/main_door.tscn")
	
