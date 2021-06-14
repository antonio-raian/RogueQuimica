extends EnemyBase

func set_animation():
	var anim = "idle"
	
	if hited:
		anim = "hit"
	
	if $animation.assigned_animation!=anim:
		$animation.play(anim)
