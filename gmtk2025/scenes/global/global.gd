extends Node2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if PauseManager.is_in_pause:
			unpause()
		else:
			pause()

func pause():
	PauseManager.pause()
	UIManager.set_ui($PauseMenu)

func unpause():
	PauseManager.unpause()
	UIManager.close_ui()
	

func cow_type_to_color(cow_type: Cow.CowType) -> Color:
	match cow_type:
		Cow.CowType.PINK:
			return Color(1, 0, 0)
		Cow.CowType.ORANGE:
			return Color(1, 1, 0)
		Cow.CowType.BLACK:
			return Color(0, 1, 1)
	return Color(1, 1, 1)
