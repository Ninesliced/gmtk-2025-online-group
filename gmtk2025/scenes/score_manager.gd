extends Node

signal gain_point
signal lose_point

@export var max_energy: float = 100.0
@export var drain_rate: float = 5.0 # drain per sec
@export var base_gain: float = 2.5 # base... gain
@export var exponent: float = 1.4 # for every extra correct cow in a batch
@export var combo_multiplier: float = 1.5 
var gain_multiplier = 1 # edit if we needed to balance
@export var penalty_per_cow: float = 5.0
@export var penalty_per_combo: float = 2.0
var energy: float
var combo: int = 0
var score: int = 0
var bar
var combo_label: Label
var score_label: Label
var time_label: Label

func _ready() -> void:
	bar = $"../UI/GameHUD/EnergyBar"
	combo_label = $"../UI/GameHUD/EnergyBar/combo label"
	score_label = $"../UI/GameHUD/EnergyBar/score label"
	time_label = $"../UI/GameHUD/EnergyBar/time label"
	energy = max_energy
	_update_ui()

func _process(delta: float) -> void:
	energy = max(energy - drain_rate * delta, 0)
	if energy == 0:
		# you lose logic
		get_tree().paused = true
		print("Game Over!")
	_update_ui()

@export var pink_represent: cow_rep
@export var black_represent: cow_rep

func apply_lasso_result(pink_count: int, black_count: int, lasso_type: Cow.CowType, captured_cows) -> void:
	pink_represent._add_cows(0, pink_count)
	black_represent._add_cows(black_count, 0)
	
	var total = pink_count + black_count
	var right_count = pink_count if lasso_type == Cow.CowType.PINK else black_count
	var wrong_count = total - right_count
	
	var points_per_right_cow = 1 + right_count
	var points_per_wrong_cow = 2*points_per_right_cow
	
	var final_point_diff = (
		points_per_right_cow * right_count - 
		points_per_wrong_cow * wrong_count
	)
	
	if final_point_diff > 0:
		gain_point.emit()
		$CatchCowSound.play()
	elif final_point_diff < 0 or (final_point_diff == 0 and total > 0):
		lose_point.emit()
		$MissCowSound.play()
	
	print(final_point_diff)
	
	energy += final_point_diff * combo_multiplier
	score += final_point_diff * combo_multiplier
	
	if energy > max_energy:
		combo_multiplier += 1
	
	_update_ui()

func _update_ui() -> void:
	bar.value = energy
	combo_label.text = "Cowmbo " + str(combo)
	score_label.text = "%04d" % score
