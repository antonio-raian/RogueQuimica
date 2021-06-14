extends EnemyBase

func set_animation():
	var anim = ""
	
	if $raycasts/ray_wall.is_colliding():
		move.x = 0
		anim = "desappear"
		
	if hited:
		anim = "hit"
	
	if $animation.assigned_animation!=anim:
		$animation.play(anim)

func _on_animation_animation_finished(anim_name):
	if (anim_name == "desappear"):
		$sprite.flip_h = !$sprite.flip_h
		$raycasts/ray_wall.scale.x *= -1
		$raycasts/ray_ground_1.position.x *= -1
		move_direction *= -1
		$animation.play("appear")
		
	if (anim_name == "appear"):		
		$animation.play("run")
