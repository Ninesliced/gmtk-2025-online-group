extends CharacterBody2D
class_name Cow

enum CowType {
	UNDEFINED,
	RED,
	YELLOW,
	BLUE,
}

@export var cow_type: CowType = CowType.UNDEFINED

@export_range(0.0, 100.0) var move_speed: float = 50.0
@export var time_between_moves: float = 2.0
# ranges for the next random position 
@export var cow_position_offset: int = 100
var target_position: Vector2
var waiting: bool = true
var timer: float = 0.0

func _ready() -> void:
	cow_type = randi_range(1, 3)
	$AnimatedSprite2D.modulate = Global.cow_type_to_color(cow_type)
	_pick_new_target()

func capture():
	queue_free() # cow ded

func _physics_process(delta: float) -> void:
	if waiting:
		timer -= delta
		if timer <= 0.0:
			_pick_new_target()
	else:
		var direction = (target_position - global_position).normalized()
		velocity = direction * move_speed
		move_and_slide()

		# If cow is very close to target, stop and start waiting
		if global_position.distance_to(target_position) <= 1.0:
			velocity = Vector2.ZERO
			waiting = true
			timer = time_between_moves

func _pick_new_target():
	var rand_x = randf_range(position.x + cow_position_offset, position.x - cow_position_offset)
	var rand_y = randf_range(position.y + cow_position_offset,position.y - cow_position_offset)
	target_position = Vector2(rand_x, rand_y)
	waiting = false
