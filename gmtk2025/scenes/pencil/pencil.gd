extends Node2D

var _is_tracing := false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				_start_tracing(event.global_position)
			else:
				_end_tracing(event.global_position)

func _start_tracing(pos):
	pass

func _end_tracing(pos):
	pass
