extends Node

var is_in_pause: bool = false
var _pause_priority : int = 0

func pause(pause_priority: int = 0) -> void:
	if pause_priority < _pause_priority:
		return
	if not is_in_pause:
		is_in_pause = true
		get_tree().paused = true
		_pause_priority = pause_priority
		
func unpause(priority: int = 0) -> void:
	if priority < _pause_priority:
		return
	if is_in_pause:
		is_in_pause = false
		get_tree().paused = false
		_pause_priority = 0
