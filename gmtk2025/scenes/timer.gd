extends Label
class_name TimerLabel

@onready var tick_timer: Timer = $Timer

var time_seconds: int = 0
var is_running: bool = false

signal timer_finished

func _ready():
	_update_display()
	tick_timer.timeout.connect(_on_tick)
	_set_timer(120)
	_timer_start()

func _on_tick():
	if is_running:
		time_seconds -= 1
		_update_display()

		if time_seconds <= 0:
			print("GAME IS OVER") # TODO: game over screen and shit
			_timer_stop()
			time_seconds = 0
			_update_display()
			emit_signal("timer_finished")

func _update_display():
	var minutes = time_seconds / 60
	var seconds = time_seconds % 60
	text = "%02d:%02d" % [minutes, seconds]

# timar api heer if we expanded 

func _timer_start():
	if time_seconds > 0:
		is_running = true
		tick_timer.start()

func _set_timer(seconds: int):
	time_seconds = seconds
	_update_display()

func _get_timer_time() -> int:
	return time_seconds

func _timer_stop():
	is_running = false
	tick_timer.stop()
