extends Node2D
class_name Cow

enum CowType {
	UNDEFINED,
	RED,
	YELLOW,
	BLUE,
}

@export var cow_type: CowType = CowType.UNDEFINED

func _ready() -> void:
	cow_type = randi_range(1, 3)
	$AnimatedSprite2D.modulate = Global.cow_type_to_color(cow_type)

func _process(delta: float) -> void:
	pass
	# TODO: cow AI

func capture():
	queue_free()
