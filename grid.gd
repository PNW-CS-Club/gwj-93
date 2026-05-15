class_name Grid extends Node2D

# Will most likely store these values:
# null -> empty square
# Plant -> Node
# Debris -> Node

@export var WIDTH = 5
@export var HEIGHT = 5
@export var COORD_OFFSET = Vector2i(0, 0)
var grid = Array([], TYPE_OBJECT, "Node", null) #Array[Node]
var plants: Array[Array] # Array of pairs that marks squares with living plants

func _ready() -> void:
	#initialize grid
	for i in range(WIDTH * HEIGHT):
		grid.append(null)

# Access elements at (x,y).
func at(x: int, y: int) -> Node: 
	return grid[y * WIDTH + x]

func put(x: int, y: int, node: Node) -> void: 
	grid[y * WIDTH + x] = node
	if node.is_class("Plant"):
		plants.append([x,y])

# TODO: Change dead plants to debris



func do_click(mouse_coords: Vector2i) -> void:
	var coords = mouse_coords - COORD_OFFSET
	# out-of-bounds check
	if clampi(coords.x, 0, WIDTH-1) != coords.x || clampi(coords.y, 0, HEIGHT-1) != coords.y:
		printerr("Cannot get tile at coordinates " + str(coords))
		return
