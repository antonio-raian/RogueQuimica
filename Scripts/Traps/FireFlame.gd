extends Area2D

export var auto_play = false

func _ready():
	$start.autostart = auto_play
	$stop.autostart = auto_play
	pass


func _on_fire_body_entered(body):
	if body.has_method("player_damage"):
		body.player_damage()

func _on_start_timeout():
	$anim.play("hit")


func _on_stop_timeout():
	$anim.play("off")
	$collision.disabled = true


func _on_anim_animation_finished(anim_name):
	if anim_name == "hit":
		$anim.play("on")
		$collision.disabled = false
