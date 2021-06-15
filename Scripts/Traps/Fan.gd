extends Area2D

func _ready():
	pass


func _on_Fan_body_entered(body):
	body.move.y -= 500
