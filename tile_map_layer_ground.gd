extends TileMapLayer

@onready var marker: Sprite2D = $Marker


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	var cell_pos = local_to_map(mouse_pos)
	highlight_cell(cell_pos)
	
func highlight_cell(cell_position: Vector2i) -> void:
	marker.position = map_to_local(cell_position)
