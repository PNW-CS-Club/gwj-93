class_name EnemyAttack extends Node2D

var grid: Grid
var rng = RandomNumberGenerator.new()

signal squares_to_attack(marked_squares: Array[Array])

enum Attacks {SQUARE, ROW_COLUMN, RANDOM}

var guaranteed_hit_chance: float = 0.10: set = on_guaranteed_hit_chance_set
var damage: int

func on_guaranteed_hit_chance_set(amount: float) -> void:
	guaranteed_hit_chance = clamp(amount, 0.0, 1.0)
	


func attack(type: Attacks = Attacks.SQUARE, size: int = 1) -> void:
	# check if there are any plants first
	if grid.plants.is_empty():
		return
	if size < 1: size = 1 # Minimum size of an attack should be 1
	var rand_num = rng.randf_range(0.0001, 1.0) # exclude 0 so there isnt a chance of guaranteed hit at 0% chance
	var guaranteed_hit: bool = rand_num <= guaranteed_hit_chance 
	match type:
		Attacks.SQUARE:
			square_attack(guaranteed_hit, size)
		Attacks.ROW_COLUMN:
			row_column_attack(guaranteed_hit) # row column attack doesnt have a size
		Attacks.RANDOM:
			random_attack(guaranteed_hit, size)


#region attacks
func square_attack(guaranteed_hit: bool, size: int) -> void:
	var attack_length: int = clampi(size,1,grid.length) # Clamp size to grid length
	attack_length = clampi(attack_length,1,grid.width)  # Clamp size to grid height
	var column: int
	var row: int
	var marked_squares: Array[Array]
	# _____________
	# | 1 | 2 |   | 
	# | 3 | 4 |   |
	# |   |   |   |
	# -------------
	if guaranteed_hit: # generate the attack to hit at least 1 plant
		var plant_coords: Array[int] = grid.plants.pick_random() # picks a random plant from the list of living plants
		var plant_x: int = plant_coords[0]
		var plant_y: int = plant_coords[1]
		if attack_length == 1: # attack a single square
			marked_squares.append(plant_coords)
			squares_to_attack.emit(marked_squares)
			return
		# else: generate the attack to hit the random plant
		# find column start index
		if (plant_x + attack_length) > (grid.length - 1):
			var diff = plant_x + attack_length - grid.length + 1
			column = plant_x - diff
		else:
			column = plant_x
		# find row start index
		if (plant_y + attack_length) > (grid.height - 1):
			var diff = plant_y + attack_length - grid.height + 1
			row = plant_y - diff
		else:
			row = plant_y
		# mark squares
		for r in range(row, row + attack_length):
			for c in range(column, column + attack_length):
				marked_squares.append([c,r])
		squares_to_attack.emit(marked_squares)
		return
	# else: generate the attack in a random spot in the grid
	column = rng.randi_range(0,grid.length - attack_length)
	row = rng.randi_range(0,grid.height - attack_length)
	if attack_length == 1:
		marked_squares.append([column,row])
		squares_to_attack.emit(marked_squares)
		return
	for r in range(row, row + attack_length):
		for c in range(column, column + attack_length):
			marked_squares.append([c,r])
	squares_to_attack.emit(marked_squares)


func row_column_attack(guaranteed_hit: bool) -> void:
	var column: int 
	var row: int 
	var marked_squares: Array[Array]
	# Attack row first then attack column.
	# _____________
	# | 1 |2 4| 3 | # The square where the attacks overlap gets hit twice
	# |   | 5 |   | 
	# |   | 6 |   |
	# -------------
	if guaranteed_hit: # Center the attack on the row and column of a random plant.
		var plant_coords: Array[int] = grid.plants.pick_random() # picks a random plant from the list of living plants
		var plant_x: int = plant_coords[0]
		var plant_y: int = plant_coords[1]
		column = plant_x
		row = plant_y
		for c in range(grid.length): # First mark the row.
			marked_squares.append([c,row])
		for r in range(grid.height): # Secondly mark the column.
			marked_squares.append([column,r])
		squares_to_attack.emit(marked_squares)
		return
	# Generate a random column and random row.
	column = rng.randi_range(0,grid.length-1)
	row = rng.randi_range(0,grid.height-1)
	for c in range(grid.length): # First mark the row.
		marked_squares.append([c,row])
	for r in range(grid.height): # Secondly mark the column.
		marked_squares.append([column,r])
	squares_to_attack.emit(marked_squares)


func random_attack(guaranteed_hit: bool, size: int) -> void:
	# size in this function is the amount of random attacks
	var marked_squares: Array[Array]
	# _____________
	# | 2 | 1 |   | 
	# | 3 |   |   |
	# |   |   | 4 |
	# -------------
	if guaranteed_hit: # The very first strike is a guaranteed hit on a random plant.
		var plant_coords: Array[int] = grid.plants.pick_random() # picks a random plant from the list of living plants
		marked_squares.append(plant_coords)
		size -= 1 # Count the guaranteed hit
	# The remaining attacks are random
	for i in range(size):
		marked_squares.append([rng.randi_range(0,grid.length), rng.randi_range(0,grid.height)])
	squares_to_attack.emit(marked_squares)
#endregion
