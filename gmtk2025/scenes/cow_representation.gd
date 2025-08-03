extends Node2D
class_name cow_rep

@export var spawn_area: Rect2

var cow_prefab: PackedScene = load("res://scenes/actors/slave cow.tscn")
@export var fence_type: String


# bitch ass code im sorry
func _add_cows(black_cows: int, pink_cows: int):
	if fence_type == "black":
		for i in black_cows:
			var cow = cow_prefab.instantiate()
			cow.cow_type = SlaveCow.CowType.BLACK
			cow.movement_area = spawn_area
			add_child(cow)
			cow.global_position = Vector2(
				randf_range(spawn_area.position.x, spawn_area.end.x),
				randf_range(spawn_area.position.y, spawn_area.end.y)
			)
	elif fence_type == "pink":
		for i in pink_cows:
			var cow = cow_prefab.instantiate()
			cow.cow_type = SlaveCow.CowType.PINK
			cow.movement_area = spawn_area
			add_child(cow)
			cow.global_position = Vector2(
				randf_range(spawn_area.position.x, spawn_area.end.x),
				randf_range(spawn_area.position.y, spawn_area.end.y)
			)
			cow.cow_type = SlaveCow.CowType.PINK
			cow.movement_area = spawn_area
