extends Area2D

func _ready():
	pass


func _on_Spike_body_entered(body):
	if body.has_method("player_damage"):
		body.player_damage()
