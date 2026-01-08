extends Area2D

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			# Left mouse click pressed
			clicked()

func clicked() -> void:
	# Start game.
	pass
