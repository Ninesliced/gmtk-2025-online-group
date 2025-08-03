extends Node2D

@onready var moo_player: AudioStreamPlayer2D = $MooPlayer

var moo_sounds: Array[AudioStream] = [
	preload("res://assets/sounds/catch_moo/sfx_cow_catch_moo_01.ogg"),
	preload("res://assets/sounds/catch_moo/sfx_cow_catch_moo_02.ogg"),
	preload("res://assets/sounds/catch_moo/sfx_cow_catch_moo_03.ogg"),
	preload("res://assets/sounds/catch_moo/sfx_cow_catch_moo_04.ogg"),
	preload("res://assets/sounds/catch_moo/sfx_cow_catch_moo_05.ogg"),
	preload("res://assets/sounds/catch_moo/sfx_cow_catch_moo_06.ogg"),
]

var min_delay: float = 3.0
var max_delay: float = 7.0

func _ready():
	randomize()
	_play_random_moo()

func _play_random_moo():
	_play_moo_loop()

func _play_moo_loop() -> void:
	await get_tree().create_timer(randf_range(min_delay, max_delay)).timeout
	var random_moo = moo_sounds[randi() % moo_sounds.size()]
	moo_player.stream = random_moo
	moo_player.play()
	_play_moo_loop()
