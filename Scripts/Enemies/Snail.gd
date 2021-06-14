extends EnemyBase

var shelled = false

func _physics_process(delta):
	apply_gravity(delta)
	if shelled:
		self.set_collision_layer_bit(1, false)
	else:
		self.set_collision_layer_bit(1, true)

func set_animation():
	var anim = "shell_idle" if shelled else "run"
	
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
		$Hitbox.position.x = -5 if $sprite.flip_h else 5
		$raycasts/ray_wall.scale.x *= -1
		$raycasts/ray_ground_1.position.x *= -1
		move_direction *= -1
		$animation.play("run")

func _on_Hitbox_body_entered(body):
	hited = true
	shelled = true
	body.move.y = -300
	yield(get_tree().create_timer(.2), "timeout")
	hited = false
	
	shelled = true
	yield(get_tree().create_timer(5), "timeout")
	shelled = false
