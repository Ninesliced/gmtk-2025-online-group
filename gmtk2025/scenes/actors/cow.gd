extends CharacterBody2D
class_name Cow

enum CowType {
	UNDEFINED,
	PINK,
	BLACK,
	ORANGE,
}

@export var cow_type: CowType = CowType.UNDEFINED

var cow_manager: CowManager

@export_range(0.0, 100.0) var move_speed: float = 50.0
@export var time_between_moves: float = 2.0
@export var cow_position_offset: int = 200

var target_position: Vector2
var waiting: bool = true
var timer: float = 0.0

func _ready() -> void:
	cow_type = randi_range(1, 2)
	add_to_group("cow")

func _process(delta: float) -> void:
	if velocity.length() > 0.01:
		$AnimatedSprite2D.speed_scale = 1.0
		$AnimatedSprite2D.play(_get_current_animation())
	else:
		$AnimatedSprite2D.speed_scale = 0.0

func _physics_process(delta: float) -> void:
	velocity = Vector2.UP * move_speed
	move_and_slide()

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

func capture():
	queue_free() # remove cow from scene
