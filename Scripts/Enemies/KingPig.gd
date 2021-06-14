extends EnemyBase

func _physics_process(delta):
	apply_gravity(delta)

func set_animation():
	var anim = "run"
	
	if $raycasts/ray_wall.is_colliding():
		move.x = 0
		anim = "idle"
		
	if hited:
		anim = "hit"
	
	if health < 1:
		anim = "dead"
	
	if $animation.assigned_animation!=anim:
		$animation.play(anim)

func _on_animation_animation_finished(anim_name):
	if (anim_name == "idle"):
		$sprite.flip_h = !$sprite.flip_h
		$sprite.position.x = 4 if $sprite.flip_h else -4
		$raycasts/ray_wall.scale.x *= -1
		move_direction *= -1
		$animation.play("run")
	
	if anim_name == "dead":
		queue_free()
		$Hitbox2/collision.set_deferred("disabled", true)
		$Hitbox3/collision.set_deferred("disabled", true)

func _on_Hitbox_body_entered(body):
	hited = true
	body.move.y = -300
	health -=1
	yield(get_tree().create_timer(.2), "timeout")
	hited = false
