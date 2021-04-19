extends Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventKey and (event as InputEventKey).scancode == KEY_ESCAPE:
		get_tree().quit()

	# if event is InputEventMouseButton and event.is_pressed():
		# $Camera.transform.origin = event.position/2
		# print("Set Camera at: ", $Camera.transform.origin)

func _ready():
	var _null = get_tree().get_root().connect("size_changed", self, "onSizeChange")

func onSizeChange():
	var size = get_viewport_rect().size
	print("Viewport: %s"%size)
