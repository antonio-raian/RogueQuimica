extends Panel

onready var sprite = $sprite
var item = {}
#func _ready():
#	sprite.texture = load("res://Assets/Itens/bag.png")

func set_item(param):
	item = param
	sprite.texture = load(param.scene)
	$sprite/label.text = param.sigla
	

func pick_from_slot():
	pass
