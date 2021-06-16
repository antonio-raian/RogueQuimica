extends Panel

onready var sprite = $sprite
var item = {}

func _ready():
	print(get_parent().get_parent().name)

func set_item(param):
	item = param
	if get_parent().get_parent().name != "PeriodicTable" or param.active:
		sprite.texture = load(param.scene)
	$sprite/label.text = param.sigla
	

func pick_from_slot():
	pass
