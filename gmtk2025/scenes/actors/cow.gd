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
@export var move_speed: float
@export var time_between_moves: float = 2.0
@export var cow_position_offset: int = 200

var target_position: Vector2
var waiting: bool = true
var timer: float = 0.0

var _sine_t = 0.0
var _sine_ampl = 0.0
var _sine_freq = 0.0

func _ready() -> void:
	cow_type = randi_range(1, 2)
	add_to_group("cow")
	
	_sine_t = randf_range(0, TAU)
	_sine_ampl = randf_range(5.0, 30.0)
	_sine_freq = randf_range(0.5, 3.0)

func _process(delta: float) -> void:
	if velocity.length() > 0.01:
		$AnimatedSprite2D.speed_scale = 1.0
		$AnimatedSprite2D.play(_get_current_animation())
	else:
		$AnimatedSprite2D.speed_scale = 0.0

func _physics_process(delta: float) -> void:
	_sine_t += delta * _sine_freq
	
	velocity = Vector2.DOWN * move_speed
	velocity.x = sin(_sine_t) * _sine_ampl
	
	var min_x = cow_manager.global_position.x - cow_manager.spawn_area_x_offset
	var max_x = cow_manager.global_position.x + cow_manager.spawn_area_x_offset
	
	if global_position.x < min_x:
		velocity.x = 0
		global_position.x = min_x + 1
	if global_position.x > max_x:
		velocity.x = 0
		global_position.x = max_x - 1
	
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
