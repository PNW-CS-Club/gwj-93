extends TileMapLayer

@onready var marker: Sprite2D = $Marker


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos: Vector2 = get_local_mouse_position()
	var cell_pos: Vector2i = local_to_map(mouse_pos)
	var tile_data: TileData = get_cell_tile_data(cell_pos)
	
	if tile_data:
		# highlight map cell
		marker.position = map_to_local(cell_pos)
		marker.visible = true
	else: 
		marker.visible = false
	
