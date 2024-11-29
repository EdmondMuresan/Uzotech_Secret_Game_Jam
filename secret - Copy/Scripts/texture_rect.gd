extends TextureRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export_enum("wolf", "mouse") var selected_animation: String = "wolf"

signal animation_finished_wolf()
signal animation_finished_mouse()

func _ready() -> void:
	visible = false

func play():
	visible = true
	animation_player.play(selected_animation)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name=="wolf":
		emit_signal("animation_finished_wolf")
	else:
		emit_signal("animation_finished_mouse")
	queue_free()
