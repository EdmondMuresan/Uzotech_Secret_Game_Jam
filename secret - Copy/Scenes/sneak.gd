extends Node2D

@onready var animated_sprite_2d = $Camera2D/TextureRect
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	animated_sprite_2d.visible=false
func death_animation():
	animated_sprite_2d.visible=true
	timer.start(1.5)
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_door.tscn")
