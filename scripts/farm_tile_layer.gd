extends TileMapLayer

@onready var highlight_marker: Sprite2D = %HighlightMarker

signal on_tile_click(coords: Vector2i)

func _process(_delta: float) -> void:
	if _get_tile_at_mouse():
		# highlight map cell
		var cell_pos: Vector2i = _get_coords_at_mouse()
		highlight_marker.position = map_to_local(cell_pos)
		highlight_marker.visible = true
	else: 
		highlight_marker.visible = false


func _input(event: InputEvent) -> void:
	var left_clicked = event is InputEventMouseButton && event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT
	if !left_clicked: return
	
	if _get_tile_at_mouse(): 
		var cell_pos: Vector2i = _get_coords_at_mouse()
		on_tile_click.emit(cell_pos)


func _get_coords_at_mouse() -> Vector2i:
	return local_to_map(get_local_mouse_position())

func _get_tile_at_mouse() -> TileData:
	return get_cell_tile_data(_get_coords_at_mouse())
