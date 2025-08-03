extends CharacterBody2D
class_name SlaveCow

enum CowType {
	UNDEFINED,
	PINK,
	ORANGE,
	BLACK,
}

@export var cow_type: CowType = CowType.UNDEFINED
@export_range(0.0, 100.0) var move_speed: float = 50.0
@export var time_between_moves: float = 2.0
@export var movement_area: Rect2

var target_position: Vector2
var waiting: bool = true
var timer: float = 0.0


func _ready() -> void:
	_pick_new_target()

func _process(delta: float) -> void:
	if velocity.length() > 0.01:
		$AnimatedSprite2D.speed_scale = 1.0
		$AnimatedSprite2D.play(_get_current_animation())
	else:
		$AnimatedSprite2D.speed_scale = 0.0


func _physics_process(delta: float) -> void:
	if waiting:
		timer -= delta
		if timer <= 0.0:
			_pick_new_target()
	else:
		var direction = (target_position - global_position).normalized()
		velocity = direction * move_speed
		move_and_slide()

		if global_position.distance_to(target_position) <= 1.0:
			velocity = Vector2.ZERO
			waiting = true
			timer = time_between_moves


func _pick_new_target():
	var rand_x = randf_range(movement_area.position.x, movement_area.position.x + movement_area.size.x)
	var rand_y = randf_range(movement_area.position.y, movement_area.position.y + movement_area.size.y)
	target_position = Vector2(rand_x, rand_y)
	waiting = false


func _cow_type_to_str(_cow_type: CowType) -> String:
	match _cow_type:
		CowType.PINK:
			return "pink"
		CowType.ORANGE:
			return "orange"
		CowType.BLACK:
			return "black"
	return ""


func _velocity_to_direction():
	var angle = fmod(velocity.angle() + TAU * 2, TAU)
	if TAU * (1.0 / 8) <= angle and angle <= TAU * (3.0 / 8):
		return "down"
	elif TAU * (3.0 / 8) <= angle and angle <= TAU * (5.0 / 8):
		return "left"
	elif TAU * (5.0 / 8) <= angle and angle <= TAU * (7.0 / 8):
		return "up"
	else:
		return "right"


func _get_current_animation():
	return "cow_" + _cow_type_to_str(cow_type) + "_" + _velocity_to_direction()
