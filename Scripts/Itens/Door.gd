extends Area2D


func _ready():
	pass


func _on_Door_body_entered(body):
	print(body.name)
	if body.name == "Player":
		$animation.play("opening")


func _on_Door_body_exited(body):
	if body.name == "Player":
		$animation.play("closing")
