extends Area2D

export var jump = -800

func _ready():
	pass


func _on_Trampoline_body_entered(body):
	body.move.y = jump
	$animation.play("active")


func _on_animation_animation_finished(anim_name):
	$animation.play("idle")
