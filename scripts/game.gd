class_name Game extends Node2D

@onready var farm = %TileMapLayerFarm
@onready var inventory: Inventory = %Hotbar
@onready var grid: Grid = %Grid

const DEFENSE_PLANT_SCENE: PackedScene = preload("uid://cj5dv7qg2wly8")

const BUFF_SEED: Item = preload("uid://2enc8i11rwcn")
const DEFENSE_SEED: Item = preload("uid://bmuyyjk7ba5o6")
const HP_SEED: Item = preload("uid://gad4q5m7vacj")
const SHOVEL: Item = preload("uid://us2gsrgycubo")
const WATER: Item = preload("uid://dot1l1nu30k12")


func _ready():
	farm.on_tile_click.connect(_click_tile)
	
	inventory.add_item(BUFF_SEED, 3)
	inventory.add_item(DEFENSE_SEED, 2)
	inventory.add_item(HP_SEED)
	inventory.add_item(WATER, 10)
	inventory.add_item(SHOVEL, 4)


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
	
	# try to find a plant to instantiate
	var plant_scene: PackedScene
	match item.type:
		Item.Type.DEF_SEED:
			plant_scene = DEFENSE_PLANT_SCENE
		Item.Type.BUFF_SEED:
			pass #plant_scene = BUFF_PLANT_SCENE
		Item.Type.HP_SEED:
			pass #plant_scene = HP_PLANT_SCENE
	
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


func _try_to_water(coords: Vector2i) -> bool:
	print("todo: water plant now")
	inventory.remove_from_hand(1)
	return true
