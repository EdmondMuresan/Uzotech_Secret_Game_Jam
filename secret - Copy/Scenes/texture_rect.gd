extends TextureRect

const _1D = preload("res://Sprites/guarddoganimation/1d.png")
const _2D = preload("res://Sprites/guarddoganimation/2d.png")
const _3D = preload("res://Sprites/guarddoganimation/3d.png")
const _4D = preload("res://Sprites/guarddoganimation/4d.png")
@onready var timer: Timer = $Timer
var images=[]
var current_index=0
func _ready() -> void:
	images.append(_1D)
	images.append(_2D)
	images.append(_3D)
	images.append(_4D)
func _on_timer_timeout() -> void:
	if current_index<3:
		current_index+=1
		texture=images[current_index]
	else:
		current_index=0
		texture=images[current_index]
