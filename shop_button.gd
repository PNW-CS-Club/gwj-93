extends MenuButton

@onready var popUpShop:PackedScene = load	("res://popup_menu.tscn")

var popUpView: Popup #the type to used is the PopUp
var viewPort: Window
var popUpWin: PopupMenu


func _on_pressed() -> void:
	popUpWin = PopupMenu.new()
	popUpWin.unresizable = false
	popUpWin.allow_search = true
	popUpWin.size = Vector2i(100,100)
	popUpWin.position = Vector2i(100,100)
	
	var shop = popUpShop.instantiate()
	
	popUpWin.add_child(shop)
	
	popUpWin.show()
	#viewPort = get_window();
	#popUpView = Popup.new();
	#popUpView.borderless = false;
	#popUpView.unresizable = false;
	#popUpView.size = viewPort.size * 0.5;
	#popUpView.position = (viewPort.size - popUpView.size) * 0.5;
	#popUpView.exclusive = true;
	#popUpView.name = "popup";
	#popUpView.visible = true;
	#popUpView.transient = true;
	#
	#var popUp = popUpShop.instantiate();
	#popUp.position = Vector2i(0,0)
	#popUp.size = popUpView.size;
	#
	#popUpView.add_child(popUp)
	#
	#popUpView.close_requested.connect(func():hide())
	#viewPort.add_child(popUpView)
	
	
	
	
