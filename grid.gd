class_name Grid extends Node2D

# Will most likely store these values:
# null -> empty square
# Plant -> Node
# Debris -> Node

@export var WIDTH = 5
@export var HEIGHT = 5
var grid = Array([], TYPE_OBJECT, "Node", null) #Array[Node]
var plants: Array[Vector2i] # Array of pairs that marks squares with living plants

func _ready() -> void:
	#initialize grid
	for i in range(WIDTH * HEIGHT):
		grid.append(null)

# Access elements at (x,y).
func at(x: int, y: int) -> Node: 
	if !_oob_check(Vector2i(x, y)): return null
	return grid[y * WIDTH + x]

func put(x: int, y: int, node: Node) -> void: 
	if !_oob_check(Vector2i(x, y)): return
	
	grid[y * WIDTH + x] = node
	if node.is_class("Plant"):
		plants.append(Vector2i(x,y))

# Logs an error message if the coords are out of bounds
func _oob_check(coords: Vector2i) -> bool:
	var in_bounds = clampi(coords.x, 0, WIDTH-1) == coords.x && clampi(coords.y, 0, HEIGHT-1) == coords.y
	if !in_bounds:
		printerr("Tile coordinates " + str(coords) + " are out of bounds")
	return in_bounds

# TODO: Change dead plants to debris
