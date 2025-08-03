extends CanvasLayer

var game = load("res://scenes/main.tscn")

func _on_continue_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($MusicPlayer, "volume_linear", 0.0, 0.5)
	TransitionManager.change_scene(game)

func _on_exit_pressed() -> void:
	get_tree().quit()
