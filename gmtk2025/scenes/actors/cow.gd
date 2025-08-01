extends Node2D
class_name Cow

enum CowType {
	UNDEFINED,
	PINK,
	ORANGE,
	BLACK,
}

@export var cow_type: CowType = CowType.UNDEFINED
@export var move_speed = 20

var cow_manager: CowManager
var velocity = Vector2(0, -1)

var _ai_target = Vector2.ZERO

func _ready() -> void:
	cow_type = randi_range(1, 3)

func _process(delta: float) -> void:
	_process_ai(delta)
	
	_velocity_to_direction()
	$AnimatedSprite2D.play(_get_current_animation())

func _physics_process(delta: float) -> void:
	var direction = (_ai_target - position).normalized()
	position += velocity * delta

func _process_ai(delta: float):
	_ai_target = Vector2(
		randf_range(
			cow_manager.spawn_area.position.x,
			cow_manager.spawn_area.end.x,
		),
		randf_range(
			cow_manager.spawn_area.position.y,
			cow_manager.spawn_area.end.y,
		),
	)

func capture():
	queue_free()

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
	var angle = fmod(velocity.angle() + TAU*2, TAU)
	if TAU*(1.0/8) <= angle and angle <= TAU*(3.0/8):
		return "down"
	elif TAU*(3.0/8) <= angle and angle <= TAU*(5.0/8):
		return "left"
	elif TAU*(5.0/8) <= angle and angle <= TAU*(7.0/8):
		return "up"
	else:
		return "right"

func _get_current_animation():
	return "cow_" + _cow_type_to_str(cow_type) + "_" + _velocity_to_direction()
