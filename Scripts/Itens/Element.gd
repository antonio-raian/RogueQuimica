extends Area2D

var elements = ["H", "C", "Na", "Cl", "N", "O", "F", "Fe", "Au"]
var quantity = 1

func _ready():
	randomize()
	if $label:
		$label.set_text(elements[randi() % elements.size()])
	pass


func _on_item_body_entered(body):
	if $label:
		$label.set_text("")
	$animation.play("colected")
#	Global.portions += quantity


func _on_animation_animation_finished(anim_name):
	queue_free()
