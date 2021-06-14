extends EnemyBase

func set_animation():
	var anim = "run"
	
	if $raycasts/ray_wall.is_colliding():
		$sprite.flip_h = !$sprite.flip_h
		$raycasts/ray_wall.scale.x *= -1
		move_direction *= -1
		$animation.play("run")
		
	if hited:
		anim = "hit"
	
	if $animation.assigned_animation!=anim:
		$animation.play(anim)
