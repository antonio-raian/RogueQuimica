extends EnemyBase

func _physics_process(delta):
	apply_gravity(delta)

func set_animation():
	var anim = "idle"
	
	if $raycasts/ray_wall.is_colliding():
		move.x = 0
		anim = "hit_wall"
	if !$raycasts/ray_ground_1.is_colliding():
		move.x = 0
		swap_side()
		
	if hited:
		anim = "hit"
	
	if $animation.assigned_animation!=anim:
		$animation.play(anim)

func _on_animation_animation_finished(anim_name):
	if (anim_name == "hit_wall"):
		swap_side()
		$animation.play("idle")

func swap_side():
	$sprite.flip_h = !$sprite.flip_h
	$raycasts/ray_wall.scale.x *= -1
	$raycasts/ray_ground_1.position.x *= -1
	move_direction *= -1
	
