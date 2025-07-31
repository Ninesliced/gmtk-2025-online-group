extends Control

@export var score_manager: ScoreManager

func _process(delta: float) -> void:
	%ScoreLabel.text = str(score_manager.score)
