class_name EnemyAttack extends Node2D

var grid: Grid
var rng = RandomNumberGenerator.new()

signal squares_to_attack(marked_squares: Array[Array])

enum Attacks {SQUARE, ROW_COLUMN, RANDOM}

var guaranteed_hit_chance: float = 0.10: set = on_guaranteed_hit_chance_set
var damage: int

func on_guaranteed_hit_chance_set(amount: float) -> void:
	guaranteed_hit_chance = clamp(amount, 0.0, 1.0)
	


func attack(type: Attacks, size: int) -> void:
	# check if there are any plants first
	if grid.plants.is_empty():
		return
	var rand_num = rng.randf_range(0.0, 1.0)
	var guaranteed_hit: bool = rand_num <= guaranteed_hit_chance 
	match type:
		Attacks.SQUARE:
			square_attack(guaranteed_hit, size)
		Attacks.ROW_COLUMN:
			pass
		Attacks.RANDOM:
			pass
	pass

#region attacks
func square_attack(guaranteed_hit: bool, size: int) -> void:
	var attack_length: int = clampi(size,1,grid.length) 
	attack_length = clampi(attack_length,1,grid.width)
	var marked_squares: Array[Array]
	# _____________
	# | 1 | 2 |   | 
	# | 3 | 4 |   |
	# |   |   |   |
	# -------------
	if guaranteed_hit: # generate the attack to hit at least 1 plant
		var plant_coords: Array = grid.plants.pick_random() # picks a random plant from the list of living plants
		if attack_length == 1:
			marked_squares.append(plant_coords)
		else:
			pass ############### TODO: CONTINUE HERE
	else: # generate the attack in a random spot in the grid
		var column: int = rng.randi_range(0,grid.length - attack_length)
		var row: int = rng.randi_range(0,grid.height - attack_length)
		if attack_length == 1:
			marked_squares.append([column,row])
		else:
			for r in range(row, row + attack_length):
				for c in range(column, column + attack_length):
					marked_squares.append([c,r])
	squares_to_attack.emit(marked_squares)

func row_column_attack(guaranteed_hit: bool) -> void:
	var column: int = rng.randi_range(0,grid.length-1)
	var row: int = rng.randi_range(0,grid.height-1)
	# Attack row first then attack column.
	# _____________
	# | 1 |2 4| 3 | # The square where the attacks overlap gets hit twice
	# |   | 5 |   | 
	# |   | 6 |   |
	# -------------
	
	pass

func random_attack(guaranteed_hit: bool) -> void:
	pass
#endregion
