extends CanvasLayer

var game = load("res://scenes/main.tscn")
var main_menu = load("res://scenes/ui/menus/main_menu.tscn")

func _process(delta: float) -> void:
	$Control/MarginContainer/VBoxContainer2/Score.text = "Score: "+ str(Global.final_score)

func _on_start_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($MusicPlayer, "volume_linear", 0.0, 0.5)
	TransitionManager.change_scene(game)


func _on_exit_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($MusicPlayer, "volume_linear", 0.0, 0.5)
	TransitionManager.change_scene(main_menu)
