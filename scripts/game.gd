class_name Game extends Node2D

@onready var farm = %TileMapLayerFarm
@onready var inventory: Inventory = $CanvasLayer/InventoryGui
@onready var grid: Grid = %Grid

const DEFENSE_PLANT_SCENE: PackedScene = preload("uid://cj5dv7qg2wly8")


func _ready():
	farm.on_tile_click.connect(_click_tile)


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
		return true
	else:
		return false
