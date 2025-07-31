extends Node2D

func _on_lasso_shape_closed(shape: PackedVector2Array) -> void:
	var cows = get_tree().get_nodes_in_group("cow")
	
	var trapped_cows = []
	for cow in cows:
		if Geometry2D.is_point_in_polygon(cow.global_position, shape):
			trapped_cows.append(cow)
	
	for trapped_cow in trapped_cows:
		trapped_cow.capture()
