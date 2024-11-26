extends Control
@onready var slot_1: TextureRect = $TextureRect/Slot1
@onready var slot_2: TextureRect = $TextureRect/Slot2
@onready var slot_3: TextureRect = $TextureRect/Slot3
@onready var texture_rect: TextureRect = $TextureRect
var first:int
var second:int
var third:int
var combination=[]
const DOORCODE_1 = preload("res://Sprites/doorcode1.png")
const DOORCODE_2 = preload("res://Sprites/doorcode2.png")
const DOORCODE_3 = preload("res://Sprites/doorcode3.png")
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
var current_slot
var answer
func _ready() -> void:
	var numbers = range(10)
	for i in numbers:
		for j in numbers:
			if j == i: 
				continue
			for k in numbers:
				if k==i or k==j:
					continue
				var element=i*100+j*10+k	
				combination.append(element)
	answer=combination.pick_random()
	print(answer)
	Global.code=answer
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
	slot_1.texture=symbols.pick_random()
	slot_2.texture=symbols.pick_random()
	slot_3.texture=symbols.pick_random()
	current_slot=slot_1
	texture_rect.texture=DOORCODE_1
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_up_pressed() -> void:
	print(current_slot)
	var index=int(current_slot.texture.resource_path[-5])
	current_slot.texture=symbols[index-1]
	print(current_slot.texture.resource_path[-5])
	
func _on_down_pressed() -> void:
	print(current_slot)
	 # Replace with function body.
	var index=int(current_slot.texture.resource_path[-5])
	if index==9:
		current_slot.texture=symbols[0]
		print(current_slot.texture.resource_path[-5])
	else:
		current_slot.texture=symbols[index+1]
		print(current_slot.texture.resource_path[-5])

func _on_pick_pressed() -> void:
	first=int(slot_1.texture.resource_path[-5])
	second=int(slot_2.texture.resource_path[-5])
	third=int(slot_3.texture.resource_path[-5])
	print(str(first)+" "+str(second)+" "+str(third))
	var my_combination=first*100+second*10+third
	if my_combination==answer:
		print("You won!")
	else:
		print("Try again!")
func _on_right_button_down() -> void:
	if current_slot==slot_1:
		current_slot=slot_2
		texture_rect.texture=DOORCODE_2
		print(current_slot)
	elif current_slot==slot_2:
		current_slot=slot_3
		texture_rect.texture=DOORCODE_3
		print(current_slot)
	elif current_slot==slot_3:
		current_slot=slot_1
		texture_rect.texture=DOORCODE_1
		print(current_slot)


func _on_left_button_down() -> void:
	if current_slot==slot_1:
		current_slot=slot_3
		texture_rect.texture=DOORCODE_3
		print(current_slot)
	elif current_slot==slot_2:
		current_slot=slot_1
		texture_rect.texture=DOORCODE_1
		print(current_slot)
	elif current_slot==slot_3:
		current_slot=slot_2
		texture_rect.texture=DOORCODE_2
		print(current_slot)
