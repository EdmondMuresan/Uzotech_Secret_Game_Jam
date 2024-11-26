extends Sprite2D

@export var code_part:int=1
const _0 = preload("res://Sprites/symbols/0.png")
const _1 = preload("res://Sprites/symbols/1.png")
const _2 = preload("res://Sprites/symbols/2.png")
const _3 = preload("res://Sprites/symbols/3.png")
const _4 = preload("res://Sprites/symbols/4.png")
const _5 = preload("res://Sprites/symbols/5.png")
const _6 = preload("res://Sprites/symbols/6.png")
const _7 = preload("res://Sprites/symbols/7.png")
const _8 = preload("res://Sprites/symbols/8.png")
const _9 = preload("res://Sprites/symbols/9.png")
var symbols=[]
var code:int
func _ready() -> void:
	symbols.append(_0)
	symbols.append(_1)
	symbols.append(_2)
	symbols.append(_3)
	symbols.append(_4)
	symbols.append(_5)
	symbols.append(_6)
	symbols.append(_7)
	symbols.append(_8)
	symbols.append(_9)
	code = 56
	print("the code is"+str(code))
	match code_part:
		1:
			if code<100:
				texture=_0
			else: 
				texture=symbols[(code/100)]
		2:
			texture=symbols[((code/10)%10)]
		3:
			texture=symbols[(code%100)]
	print(texture)	
