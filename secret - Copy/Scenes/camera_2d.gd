extends Camera2D

# The base zoom level that works for your game
const BASE_ZOOM = 6.0
# The target resolution width to scale from
const TARGET_WIDTH = 1920.0

func _ready() -> void:
	# Set initial zoom and connect signal for resizing
	update_zoom(get_viewport().size)
	get_viewport().connect("size_changed", Callable(self, "_on_viewport_size_changed"))

func _on_viewport_size_changed():
	# Update zoom dynamically when viewport size changes
	update_zoom(get_viewport().size)

func update_zoom(viewport_size: Vector2):
	# Calculate zoom based on screen size and maintain the base zoom level
	var zoom_factor = BASE_ZOOM * viewport_size.x / TARGET_WIDTH
	zoom = Vector2(zoom_factor, zoom_factor)
