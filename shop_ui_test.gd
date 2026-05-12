extends CanvasLayer

var currItem = 0
var select = 0

@onready var shopButton: TextureButton = %shopButton
@onready var seedPanel: Panel = %seedPanel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seedPanel.hide()
	
	shopButton.pressed.connect(_on_shop_button_pressed)

func _on_shop_button_pressed():
	seedPanel.visible = not seedPanel.visible
	
	

func switchItem(select): #here we can add random seeds that we want we can do get node 3 times and have them show
	for i in range(Global.buyableItems.size()):
		if select == i:
			currItem = select
			print(Global.buyableItems[currItem])
			get_node("seedPanel/Control/name").text = Global.buyableItems[currItem]["Name"]
	

func _on_buy_pressed() -> void:
	TYPE_NIL

func _on_next_pressed() -> void:
	switchItem(currItem+1)


func _on_prev_pressed() -> void:
	switchItem(currItem-1)
