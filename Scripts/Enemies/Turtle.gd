extends Area2D

var hited = false

var spiked = false
var spikes_out = false
var spikes_in = false

func _process(delta):
	set_animation()

func set_animation():
	var anim = "idle_1" 
	
	if spiked:
		anim = "idle_2"
		
	if hited:
		anim = "hit"
		
	if spikes_out:
		anim = "spikes_out"
	if spikes_in:
		anim = "spikes_in"
		
	if $animation.assigned_animation!=anim:
		$animation.play(anim)

func _on_animation_animation_finished(anim_name):
	if (anim_name == "spikes_out"):
		spikes_out = false
		spiked = true
		yield(get_tree().create_timer(5), "timeout")
		spikes_in = true
	if anim_name == "spikes_in":
		spikes_in = false
		spiked = false

func _on_Hitbox_body_entered(body):
	hited = true
	body.move.y = -600
	yield(get_tree().create_timer(.2), "timeout")
	hited = false
	spikes_out = true
	

func _on_Turtle_body_entered(body):
	if spiked or !hited:
		if body.has_method("player_damage"):
			body.player_damage()
