extends Node2D

@onready var timer: Timer = $Timer
@export var player:CharacterBody2D
@export var animation:TextureRect
var error_handling=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.animation_finished_mouse.connect(_on_animation_finished)
func death_animation():
	animation.selected_animation="mouse"
	animation.play()
	
func _on_animation_finished() : 
		player.queue_free()
		get_tree().change_scene_to_file("res://Scenes/main_door.tscn")
