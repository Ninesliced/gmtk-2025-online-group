extends Node2D

@export var sprite_neutral: Texture2D
@export var sprite_happy: Texture2D
@export var sprite_sad: Texture2D

func _ready() -> void:
	$Node2D/Sprite2D.play("neutral")

func set_sprite_happy():
	$Node2D/Sprite2D.play("happy")
	
func set_sprite_angry():
	$Node2D/Sprite2D.play("angry")
	
func set_sprite_neutral():
	$Node2D/Sprite2D.play("neutral")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_score_manager_gain_point() -> void:
	set_sprite_happy()
	$HappySound.play()
	$AnimationPlayer.play("bounce")

func _on_score_manager_lose_point() -> void:
	set_sprite_angry()
	$AngrySound.play()
	$AnimationPlayer.play("shake")

func _on_score_manager_gain_a_lot_point() -> void:
	set_sprite_happy()
	$HappySound.play()
	$AnimationPlayer.play("bounce")
	$SparklesParticle.emitting = true
