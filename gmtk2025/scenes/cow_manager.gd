extends Node2D
class_name CowManager

@export var target_cow_count: int = 20
@export var spawn_area_x_offset: float = 120
@export var spawn_area_y_offset: float = 40
@export var spawn_interval: float = 2.0 
@export var spawn_batch_size: int = 4

var cow_prefab: PackedScene = load("res://scenes/actors/cow.tscn")
var spawn_timer: Timer
@export_range(0.0, 100.0) var spawned_cows_min_speed: int = 40
@export_range(0.0, 100.0) var spawned_cows_max_speed: int = 70

func _ready() -> void:
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.one_shot = false
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)

func _on_spawn_timer_timeout() -> void:
	var cows = get_tree().get_nodes_in_group("cow")
	var cow_count = cows.size()
	
	if cow_count < target_cow_count:
		var spawn_count = min(spawn_batch_size, target_cow_count - cow_count)
		for i in range(spawn_count):
			var cow = cow_prefab.instantiate()
			cow.cow_manager = self
			cow.move_speed = randf_range(
				spawned_cows_min_speed,
				spawned_cows_max_speed
			)
			add_child(cow)
			cow.global_position = Vector2(
				global_position.x + randf_range(-spawn_area_x_offset, spawn_area_x_offset),
				global_position.y + randf_range(0, spawn_area_y_offset)
			)
