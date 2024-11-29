extends Node

@onready var _1: Sprite2D = $"1"
@onready var _2: Sprite2D = $"2"
@onready var _3: Sprite2D = $"3"
@onready var _4: Sprite2D = $"4"
@onready var _5: Sprite2D = $"5"
@onready var _6: Sprite2D = $"6"
const _s0 = preload("res://Sprites/symbols/0.png")
const _s1 = preload("res://Sprites/symbols/1.png")
const _s2 = preload("res://Sprites/symbols/2.png")
const _s3 = preload("res://Sprites/symbols/3.png")
const _s4 = preload("res://Sprites/symbols/4.png")
const _s5 = preload("res://Sprites/symbols/5.png")
const _s6 = preload("res://Sprites/symbols/6.png")
const _s7 = preload("res://Sprites/symbols/7.png")
const _s8 = preload("res://Sprites/symbols/8.png")
const _s9 = preload("res://Sprites/symbols/9.png")
var symbols=[]
var tiles=[]
@export var code = 3
var deleted
var new_position
var positions_for_tiles=[]
func _ready() -> void:
	tiles.append(_1)
	tiles.append(_2)
	tiles.append(_3)
	tiles.append(_4)
	tiles.append(_5)
	tiles.append(_6)
	symbols.append(_s0)
	symbols.append(_s1)
	symbols.append(_s2)
	symbols.append(_s3)
	symbols.append(_s4)
	symbols.append(_s5)
	symbols.append(_s6)
	symbols.append(_s7)
	symbols.append(_s8)
	symbols.append(_s9)
	for image in tiles:
		image.texture=symbols[code-1]
		positions_for_tiles.append(Vector2(image.position.x,image.position.y))
		print(image.position.x,image.position.y)
	deleted=tiles.pick_random()
	deleted.texture=null
	for image in tiles:
		new_position=positions_for_tiles.pick_random()
		image.position=new_position
		positions_for_tiles.erase(new_position)
func _process(delta: float) -> void:
	pass
