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
		$name.text = selected_item.name
		if $value:
			$value.text = "R$ "+str(selected_item.value)+",00"
		elif $quantity:
			$quantity.text = str(selected_item.quantity)
		elif $details:
			$details.text = selected_item.details
		$sprite.texture = load(selected_item.scene)
		$sprite.scale = Vector2(2.0,2.0)
		$sprite/label.text = selected_item.sigla

func slot_gui_input(event: InputEvent, slot: ItemClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			selected_item = slot.item
			if self.name != "PeriodicTable" or slot.item.active:
				set_details()

func _on_btn_buy_pressed():
	if selected_item:
		Global.buy_in_store(selected_item)

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
