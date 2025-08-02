extends Node2D

@export var close_detection_radius = 120
@export var left_click_cow_type: Cow.CowType = Cow.CowType.UNDEFINED
@export var right_click_cow_type: Cow.CowType = Cow.CowType.UNDEFINED
@export var lasso_pink_texture: Texture2D 
@export var lasso_orange_texture: Texture2D 

signal shape_closed(shape: PackedVector2Array, cow_type: Cow.CowType)

@onready var line: Line2D = $Line2D

var _is_tracing := false
var _beginning_pos = null
var _lasso_type: Cow.CowType
var _last_trace_point: Vector2

func _process(delta):
	$StretchSound.volume_linear = move_toward(
		$StretchSound.volume_linear, 0.0, delta*3
	)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if _is_tracing: 
			_process_tracing(event.global_position)
	if event is InputEventMouseButton:
		if event.is_pressed():
			_start_tracing(event.global_position, event.button_index)
		else:
			_end_tracing(event.global_position)

func _start_tracing(pos: Vector2, button_index: int):
	if button_index == MOUSE_BUTTON_LEFT:
		_lasso_type = left_click_cow_type
		line.texture = lasso_pink_texture
	elif button_index == MOUSE_BUTTON_RIGHT:
		_lasso_type = right_click_cow_type
		line.texture = lasso_orange_texture
	
	$StretchSound.play()
	
	_is_tracing = true 
	_last_trace_point = pos
	_beginning_pos = pos
	
	line.clear_points()
	line.add_point(pos)
	line.closed = true

func _end_tracing(pos: Vector2):
	_is_tracing = false
	
	if pos:
		line.closed = true
		shape_closed.emit(PackedVector2Array(line.points), _lasso_type)
	
	$StretchSound.stop()
	
	_lasso_type = Cow.CowType.UNDEFINED
	_beginning_pos = null
	line.clear_points()

func _process_tracing(pos):
	line.add_point(pos)
	
	var diff = ((_last_trace_point - pos).length())
	$StretchSound.volume_linear = clamp(diff / 10, 0.4, 1.5)
	$StretchSound.pitch_scale = clamp(diff / 4, 0.8, 2.5)
	
	_last_trace_point = pos
