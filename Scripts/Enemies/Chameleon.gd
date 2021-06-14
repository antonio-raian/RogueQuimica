extends EnemyBase

func _physics_process(delta):
	apply_gravity(delta)

func set_animation():
	var anim = "run"
	
	if $raycasts/ray_wall.is_colliding() or !$raycasts/ray_ground_1.is_colliding():
		move.x = 0
		anim = "idle"
		
	if hited:
		anim = "hit"
	
	if $animation.assigned_animation!=anim:
		$animation.play(anim)

func _on_animation_animation_finished(anim_name):
	if (anim_name == "idle"):
		$sprite.flip_h = !$sprite.flip_h
		$sprite.position.x = 23 if $sprite.flip_h else -17
		$Hitbox.position.x = 6 if $sprite.flip_h else 0
			
		$raycasts/ray_wall.scale.x *= -1
		$raycasts/ray_ground_1.position.x *= -1
		move_direction *= -1
		$animation.play("run")
