extends Node

signal gain_point
signal gain_a_lot_point
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

var score_particle_prefab = load("res://scenes/ui/score_particle.tscn")

func _ready() -> void:
	bar = $"../UI/GameHUD/EnergyBar"
	combo_label = $"../UI/GameHUD/EnergyBar/combo label"
	score_label = $"../UI/GameHUD/EnergyBar/score label"
	time_label = $"../UI/GameHUD/EnergyBar/time label"
	energy = max_energy
	_update_ui()

func _process(delta: float) -> void:
	energy = max(energy - drain_rate * delta, 0)
	#if energy == 0:
		## you lose logic
		#get_tree().paused = true
		#print("Game Over!")
	_update_ui()

@export var pink_represent: cow_rep
@export var black_represent: cow_rep

func apply_lasso_result(pink_count: int, black_count: int, lasso_type: Cow.CowType, captured_cows) -> void:
	pink_represent._add_cows(0, pink_count)
	black_represent._add_cows(black_count, 0)
	
	var total = pink_count + black_count
	var right_count = pink_count if lasso_type == Cow.CowType.PINK else black_count
	var wrong_count = total - right_count
	
	# Keep this base calculation simple
	var points_per_right_cow = 10 # Base points for a correct cow
	var penalty_for_wrong_cow = 20 # Base penalty for a wrong cow
	
	var base_point_diff = (points_per_right_cow * right_count) - (penalty_for_wrong_cow * wrong_count)
	
	var final_point_diff = base_point_diff # Start with the base difference
	
	if base_point_diff > 0:
		# --- SUCCESSFUL CATCH ---
		combo += 1 # <-- FIX #1: Actually increase the combo count!
		
		# Apply a multiplier that grows with the combo streak
		var current_multiplier = 1.0 + (combo * 0.5) # Example: combo 1 = x1.5, combo 2 = x2.0, etc.
		final_point_diff *= current_multiplier
		
		# Emit signals based on final calculated points
		if final_point_diff > 150:
			gain_a_lot_point.emit()
		else:
			gain_point.emit()
		$CatchCowSound.play()

	elif base_point_diff < 0 or (base_point_diff == 0 and total > 0):
		# --- FAILED CATCH ---
		combo = 0 # <-- FIX #2: Reset the combo on a miss
		lose_point.emit()
		$MissCowSound.play()
	
	# Make sure points are integers for score and particles
	final_point_diff = int(final_point_diff)
	
	print("Points gained: ", final_point_diff, " | New Combo: ", combo)
	
	energy += final_point_diff
	score += final_point_diff
	score = max(0, score)
	
	# Your "overcharge" logic could be a separate mechanic if you want
	# if energy > max_energy:
		# gain_special_power() 
	
	for cow in captured_cows:
		var score_particle = score_particle_prefab.instantiate()
		var particle_points = 0
		if cow.cow_type == lasso_type:
			# Show the base points multiplied by the combo
			particle_points = int(points_per_right_cow * (1.0 + (combo * 0.5)))
		else:
			particle_points = -penalty_for_wrong_cow
			
		score_particle.score = particle_points
		add_child(score_particle)
		score_particle.global_position = cow.global_position
		score_particle.position.x -= 32
	
	_update_ui()

func _update_ui() -> void:
	bar.value = energy
	combo_label.text = "Cowmbo " + str(combo)
	score_label.text = "%04d" % score
