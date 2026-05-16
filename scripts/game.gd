class_name Game extends Node2D

@onready var farm = %TileMapLayerFarm
@onready var inventory: Inventory = %Hotbar
@onready var grid: Grid = %Grid

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


func _ready():
	# Signals
	farm.on_tile_click.connect(_click_tile)
	
	inventory.add_item(BUFF_BUFF_SEED_ITEM, 2)
	inventory.add_item(BUFF_DEF_SEED_ITEM, 3)
	inventory.add_item(BUFF_HP_SEED_ITEM, 4)
	inventory.add_item(BUFF_SEED_ITEM, 5)
	inventory.add_item(DEF_DEF_SEED_ITEM, 6)
	inventory.add_item(DEF_HP_SEED_ITEM, 7)
	inventory.add_item(DEF_SEED_ITEM, 8)
	inventory.add_item(HP_HP_SEED_ITEM, 9)
	inventory.add_item(HP_SEED_ITEM)
	inventory.add_item(WATER_ITEM, 10)
	inventory.add_item(SHOVEL_ITEM, 4)


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
	if farm.get_cell_atlas_coords(coords) == Vector2i(4,2): # Debris
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


func _dig_up(coords: Vector2i) -> void:
	var target = grid.at(coords)
	grid.put(coords, null)
	grid.remove_child(target)
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
	if farm.get_cell_atlas_coords(coords) == Vector2i.ZERO: # Wet farm tile is at (0,0) on TileSet
		print("> failed because this plant has already been leveled this day")
		return false
	# Update the level of the plant. 
	plant.stats.level += 1
	# Update the farm tile to the watered tile
	farm.set_cell(coords, 9, Vector2i.ZERO)
	
	
	inventory.remove_from_hand(1)
	print("> success")
	return true
