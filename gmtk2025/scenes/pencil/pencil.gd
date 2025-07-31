extends Node2D

@export var close_detection_radius = 64

@onready var line: Line2D = $Line2D

var _is_tracing := false
var _beginning_pos = null

func _process(delta):
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if _is_tracing: 
			_process_tracing(event.global_position)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				_start_tracing(event.global_position)
			else:
				_end_tracing(event.global_position)

func _start_tracing(pos: Vector2):
	_is_tracing = true 
	_beginning_pos = pos
	
	line.clear_points()
	line.add_point(pos)
	line.closed = false

func _end_tracing(pos: Vector2):
	_is_tracing = false
	
	if pos.distance_to(_beginning_pos) < close_detection_radius:
		line.closed = true
		print("close")
	
	_beginning_pos = null

func _process_tracing(pos):
	line.add_point(pos)
