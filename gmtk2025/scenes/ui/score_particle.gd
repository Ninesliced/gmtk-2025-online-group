extends Label

var color: Color:
	set(value):
		color = value
		label_settings.font_color = value

var score: int:
	set(value):
		score = value
		if score >= 0:
			modulate = Color.WHITE
			text = "+" + str(score)
		else:
			modulate = Color.CRIMSON
			text = "-" + str(abs(score))

var dissapear_time = 2.0
var move_speed = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dissapear_time -= delta
	position.y -= move_speed * delta
	if dissapear_time <= 0.0:
		queue_free()
