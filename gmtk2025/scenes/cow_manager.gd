extends Node2D
class_name CowManager

@export var score_manager: ScoreManager
@export var target_cow_count: int = 20
@export var spawn_area: Rect2

var cow_prefab: PackedScene = load("res://scenes/actors/cow.tscn")

func _process(delta: float) -> void:
	var cows = get_tree().get_nodes_in_group("cow")
	var cow_count = cows.size()
	
	if cow_count < target_cow_count:
		for i in range(target_cow_count - cow_count):
			var cow = cow_prefab.instantiate()
			cow.cow_manager = self
			print(cow.cow_manager)
			add_child(cow)
			cow.global_position = Vector2(
				global_position.x + randf_range(0, 140),
				global_position.y
			)

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
