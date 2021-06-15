extends GridContainer

onready var ItemStore = preload("res://Scenes/Prefabs/StoreItem.tscn")

func _ready():
	for i in Global.store:
		var item = ItemStore.instance()
		add_child(item)
		item.set_item(i)
	pass
