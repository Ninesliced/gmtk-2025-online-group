extends Node2D

enum CowType {
	WHITE,
	BLACK,
	BROWN,
}

@export var cow_type: CowType = randi_range(0, 2)

func _ready() -> void:
	cow_type = randi_range(0, 2)
	match cow_type:
		CowType.WHITE:
			$AnimatedSprite2D.modulate = Color(1, 0, 0)
		CowType.BLACK:
			$AnimatedSprite2D.modulate = Color(1, 1, 0)
		CowType.BROWN:
			$AnimatedSprite2D.modulate = Color(0, 1, 1)
	pass

func _process(delta: float) -> void:
	pass
	# TODO: cow AI

func capture():
	queue_free()
