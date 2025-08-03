extends CanvasLayer

var game = load("res://scenes/main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MusicPlayer.play() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continue_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($MusicPlayer, "volume_linear", 0.0, 0.5)
	TransitionManager.change_scene(game)
	


func _on_exit_pressed() -> void:
	pass # Replace with function body.
