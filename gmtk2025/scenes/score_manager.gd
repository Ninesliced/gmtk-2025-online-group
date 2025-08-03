extends Node

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

func _ready() -> void:
	bar = $"../UI/EnergyBar"
	combo_label = $"../UI/EnergyBar/combo label"
	score_label = $"../UI/EnergyBar/score label"
	energy = max_energy
	_update_ui()

func _process(delta: float) -> void:
	energy = max(energy - drain_rate * delta, 0)
	if energy == 0:
		# you lose logic
		get_tree().paused = true
		print("Game Over!")
	_update_ui()

func apply_lasso_result(pink_count: int, black_count: int) -> void:
	var total = pink_count + black_count
	if total > 0 and (pink_count == 0 or black_count == 0):
		# all one color
		combo += 1
		var gain = base_gain * pow(total, exponent) + combo * combo_multiplier
		score += gain * gain_multiplier
		energy = min(energy + gain, max_energy)
		print(String("%.1f" % gain), " energy (Combo", combo, ")")
	else:
		# mixed or zero
		var loss = total * penalty_per_cow + combo * penalty_per_combo
		energy = max(energy - loss, 0)
		combo = 0
		print(String("%.1f" % loss), " energy (combo reset)")
	_update_ui()

func _update_ui() -> void:
	bar.value = energy
	combo_label.text = "Combo: " + str(combo)
	score_label.text = "ur skor: " + str(score)
