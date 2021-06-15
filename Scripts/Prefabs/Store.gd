extends Popup

const ItemClass = preload("res://Scripts/Prefabs/StoreItem.gd")
onready var grid = $grid
var selected_item = null

func _ready():
	self.visible = true
	for item in grid.get_children():
		item.connect("gui_input", self, "slot_gui_input", [item])
	pass
	

func set_details():
	if selected_item:
		$box_details/name.text = selected_item.name
		if $box_details/value:
			$box_details/value.text = "R$ "+str(selected_item.value)+",00"
		elif $box_details/quantity:
			$box_details/quantity.text = str(selected_item.quantity)
		$box_details/sprite.texture = load(selected_item.scene)
		$box_details/sprite.scale = Vector2(2.0,2.0)
		$box_details/sprite/label.text = selected_item.sigla

func slot_gui_input(event: InputEvent, slot: ItemClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print(slot.item)
			selected_item = slot.item
			set_details()

func _on_btn_buy_pressed():
	if selected_item:
		Global.buy_in_store(selected_item.id)

func _on_btn_close_pressed():
	finish()
	
func finish():
	print("Finalizando.....")
	get_tree().paused = false
	queue_free()
	pass

func _on_Invetory_popup_hide():
	finish()

func _on_btn_use_pressed():
	if selected_item:
		Global.use_item(selected_item.id, 1)


func _on_btn_drop_pressed():
	if selected_item:
		Global.drop_item(selected_item.id, 1)


func _on_Store_popup_hide():
	finish()
