extends Area2D

export var quantity = 1

func _ready():
	pass

func _on_item_body_entered(body):
	if $label:
		$label.set_text("")
	$animation.play("colected")
	Global.coins += quantity

func _on_animation_animation_finished(anim_name):
	queue_free()
