class_name Grid extends Node2D

# Will most likely store these values:
# null -> empty square
# Plant -> Node
# Debris -> Node

@export var width = 5
@export var height = 5
var grid = Array([], TYPE_OBJECT, "Node", null) #Array[Node]
var plants: Array[Array] # Array that marks squares with living plants

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#initialize grid
	for i in range(width * height):
		grid.append(null)

# Access elements at (x,y).
func at(x: int, y: int) -> Node: 
	return grid[y * width + x]

func put(x: int, y: int, type: Node) -> void: 
	grid[y * width + x] = type
	if type.is_class("Plant"):
		plants.append([x,y])

# TODO: Change dead plants to debris
