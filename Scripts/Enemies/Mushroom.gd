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
