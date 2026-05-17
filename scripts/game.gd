class_name Game extends Node2D

@onready var farm = %TileMapLayerFarm
@onready var inventory: Inventory = %Hotbar
@onready var grid: Grid = %Grid
@onready var shop: Shop = %Shop 
@onready var cabin: Cabin = %Cabin
@onready var wallet: Wallet = %CoinOverlay
@onready var daylight_cycle: DaylightCycle = %DaylightCycle

enum GameStates {DAWN, DAY, DUSK, NIGHT}

const BUFF_PLANT_SCENE: PackedScene = preload("uid://dciwxjx24qc3d")
const DEF_PLANT_SCENE: PackedScene = preload("uid://cj5dv7qg2wly8")
const HP_PLANT_SCENE: PackedScene = preload("uid://dka8tnw2nv8vq")
const BUFF_BUFF_PLANT_SCENE: PackedScene = preload("uid://dv2es8w1ejiuj")
const DEF_DEF_PLANT_SCENE: PackedScene = preload("uid://clfojmjqriv6d")
const HP_HP_PLANT_SCENE: PackedScene = preload("uid://ch6t652jrihl5")
const DEF_BUFF_PLANT_SCENE: PackedScene = preload("uid://dwx5ysqk211ee")
const DEF_HP_PLANT_SCENE: PackedScene = preload("uid://bamydx7slu2tx")
const HP_BUFF_PLANT_SCENE: PackedScene = preload("uid://ml2bjogn0vg")

const BUFF_BUFF_SEED_ITEM: Item = preload("uid://lbrpwm774xio")
const BUFF_DEF_SEED_ITEM: Item = preload("uid://cnyfoeggl3wu4")
const BUFF_HP_SEED_ITEM: Item = preload("uid://cyvhvfsxnkax2")
const BUFF_SEED_ITEM: Item = preload("uid://2enc8i11rwcn")
const DEF_DEF_SEED_ITEM: Item = preload("uid://cf1rhemkxk6p7")
const DEF_HP_SEED_ITEM: Item = preload("uid://djbxsbsd7pdbn")
const DEF_SEED_ITEM: Item = preload("uid://bmuyyjk7ba5o6")
const HP_HP_SEED_ITEM: Item = preload("uid://h0n2yn0ei1w0")
const HP_SEED_ITEM: Item = preload("uid://gad4q5m7vacj")

const SHOVEL_ITEM: Item = preload("uid://us2gsrgycubo")
const WATER_ITEM: Item = preload("uid://dot1l1nu30k12")

const current_state = GameStates.DAWN
var current_day: int

# Atlas coords
const WET_TILE: Vector2i = Vector2i(0,0)
const DRY_TILE: Vector2i = Vector2i(1,0)
const DEBRIS_TILE: Vector2i = Vector2i(4,2)

func _ready():
	# Signals
	farm.on_tile_click.connect(_click_tile)
	cabin.end_day.connect(_end_day)
	#Game State
	set_state(GameStates.DAWN)
	current_day = 0
	shop.item_bought.connect(_click_purchase)
	inventory.add_item(BUFF_BUFF_SEED_ITEM, 2)

#region Game State

func set_state(state: Game.GameStates) -> void:
	print("setting state to:",state)
	match state:
		GameStates.DAWN:
			_handle_dawn()
		GameStates.DAY:
			_handle_day()
		GameStates.DUSK:
			_handle_dusk()
		GameStates.NIGHT:
			_handle_night()
		
## The game starts here. Give the player resources
func _handle_dawn() -> void:
	current_day += 1
	# Display good day overview if not the first day
	if current_day > 1:
		pass #Display good day overview
	
	# Give the player some basic resources
	# seeds, coins, shovel uses, watering can uses
	_give_resources() # Give player resources.
	
	_reset_wet_to_dry() # Reset wet tiles to dry.
	_add_debris() # Place some debris on empty squares.
	
	daylight_cycle.transition_to(DaylightCycle.Phase.DAWN)
	print("state is now dawn")
	set_state(GameStates.DAY)
	pass
	
## The player does most of their actions here
func _handle_day() -> void:
	daylight_cycle.transition_to(DaylightCycle.Phase.DAY)
	print("state is now day")
	pass

## The attacks happen during this state
func _handle_dusk() -> void: 
	daylight_cycle.transition_to(DaylightCycle.Phase.DUSK)
	print("state is now dusk")
	pass

## We check if the player survived at this stage.
func _handle_night() -> void:
	daylight_cycle.transition_to(DaylightCycle.Phase.NIGHT)
	print("state is now night")
	pass

func _end_day() -> void:
	set_state(GameStates.DUSK)
#endregion

#region Player Actions
func _click_tile(coords: Vector2i) -> void:
	print("\nclicked on farm plot at " + str(coords))
	var plot_contents: Node = grid.at(coords)
	
	if inventory.stack_in_hand:
		var item: Item = inventory.stack_in_hand.item
		
		if !plot_contents:
			print("> trying to place " + item.name)
			if _try_to_plant(coords, item):
				print("> success")
				return
			else: print("> failed")
		elif plot_contents is Plant:
			if item.type == Item.Type.WATER:
				_try_to_water(coords)
		else:
			if item.type == Item.Type.SHOVEL:
				_dig_up(coords)


## If the given item is plantable, it is consumed and the plant is created.
## Returns whether it was successful.
## This function assumes that `item` is in hand and the plot is empty.
func _try_to_plant(coords: Vector2i, item: Item) -> bool:
	if farm.get_cell_atlas_coords(coords) == DEBRIS_TILE: # Debris
		print("> failed because the land has debris.")
		return false
	# try to find a plant to instantiate
	var plant_scene: PackedScene
	match item.type:
		Item.Type.BUFF_SEED:
			plant_scene = BUFF_PLANT_SCENE
		Item.Type.DEF_SEED:
			plant_scene = DEF_PLANT_SCENE
		Item.Type.HP_SEED:
			plant_scene = HP_PLANT_SCENE
		Item.Type.BUFF_BUFF_SEED:
			plant_scene = BUFF_BUFF_PLANT_SCENE
		Item.Type.DEF_DEF_SEED:
			plant_scene = DEF_DEF_PLANT_SCENE
		Item.Type.HP_HP_SEED:
			plant_scene = HP_HP_PLANT_SCENE
		Item.Type.BUFF_DEF_SEED:
			plant_scene = DEF_BUFF_PLANT_SCENE
		Item.Type.BUFF_HP_SEED:
			plant_scene = HP_BUFF_PLANT_SCENE
		Item.Type.DEF_HP_SEED:
			plant_scene = DEF_HP_PLANT_SCENE
	
	if plant_scene:
		var plant: Plant = plant_scene.instantiate()
		plant.global_position = farm.to_global(farm.map_to_local(coords))
		inventory.remove_from_hand(1)
		grid.put(coords, plant)
		grid.add_child(plant)
		return true
	else:
		return false

## Use the shovel to remove debris
func _dig_up(coords: Vector2i) -> void:
	var target = grid.at(coords)
	if target is Debris:
		grid.put(coords, null)
		grid.remove_child(target)
		farm.set_cell(coords, 9, DRY_TILE)
		inventory.remove_from_hand(1)

## If the coordinate is a plant, the watering can is used and the plant is upgraded.
## Returns whether it was successful.
## A plant can only be watered 1 time per day.
func _try_to_water(coords: Vector2i) -> bool:
	print("Trying to water", coords)
	var plant: Plant = grid.at(coords)
	# Fail if the plant is already max level.
	if plant.stats.level >= 3:
		print("> failed because already max level:", plant.stats.level)
		return false
	# Fail if the plant has already been leveled up this turn.
	if farm.get_cell_atlas_coords(coords) == WET_TILE:
		print("> failed because this plant has already been leveled this day")
		return false
	# Update the level of the plant. 
	plant.stats.level += 1
	# Update the farm tile to the watered tile
	farm.set_cell(coords, 9, WET_TILE)
	
	
	inventory.remove_from_hand(1)
	print("> success")
	return true
#endregion

#region Private Helper Functions
## Give the player resources
func _give_resources() -> void:
	print("TODO: Give player resources")
	pass
## Used to place debris in the farm. Only places in empty tiles
func _add_debris() -> void:
	var rng = RandomNumberGenerator.new()
	var debris_amount = rng.randi_range(0,4)
	while debris_amount > 0:
		var cell_coords: Vector2i = Vector2i(rng.randi_range(0,grid.WIDTH-1), rng.randi_range(0,grid.HEIGHT-1))
		var cell = grid.at(cell_coords)
		if cell == null: 
			var debris: Debris = Debris.new()
			grid.put(cell_coords, debris)
			grid.add_child(debris)
			farm.set_cell(cell_coords, 9, DEBRIS_TILE)
		debris_amount -= 1 
		#NOTE Even if the function failed to add certain debris we still reduce the amount.
		#NOTE This gives some grace to the player so that they see less debris with nearly full boards.

#adds item to inventory and subtracts price from wallet
func _click_purchase(item: Item, price: int) ->void:
	if price > wallet.coins:
		print("You do not have enough money")
	else:
		print("You have bought the item")
		wallet.change_balance(-price)
		inventory.add_item(item)
	

## Reset all the wet tiles to dry tiles
func _reset_wet_to_dry() -> void:
	var wet_tiles: Array[Vector2i] = farm.get_used_cells_by_id(9,WET_TILE)
	for i in wet_tiles:
		farm.set_cell(i, 9, DRY_TILE)
			
#endregion
