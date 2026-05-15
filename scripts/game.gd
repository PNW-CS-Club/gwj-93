class_name Game extends Node2D

@onready var farm = %TileMapLayerFarm

func _ready():
	farm.on_tile_click.connect(click_tile)

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_0:
				print("key 0 pressed")
			KEY_1:
				print("key 1 pressed")


func click_tile(coords: Vector2i) -> void:
	print("farm.on_tile_click signal recieved: " + str(coords))
