extends Area2D
class_name Elements

var quantity = 1
onready var label = $label
onready var sprite = $sprite
var item = null

func _ready():
	randomize()
	item = Global.store[randi() % Global.store.size() - 1]
	sprite.texture = load(item.scene)
	

func _on_item_body_entered(body):
	if label:
		label.set_text("")
	$animation.play("colected")
	Global.add_item(item, quantity)

func _on_animation_animation_finished(anim_name):
	queue_free()
