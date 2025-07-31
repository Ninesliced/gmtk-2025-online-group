extends Node2D

@export var score_manager: ScoreManager

func _on_lasso_shape_closed(shape: PackedVector2Array, cow_type: Cow.CowType) -> void:
	var cows = get_tree().get_nodes_in_group("cow")
	
	var trapped_cows = []
	for cow in cows:
		if Geometry2D.is_point_in_polygon(cow.global_position, shape):
			trapped_cows.append(cow)
	
	var score = 0
	for cow in trapped_cows:
		if cow_type == cow.cow_type:
			score += 1
		else:
			score -= 1
		cow.capture()
	
	score_manager.add_score(score)
