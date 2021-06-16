extends CanvasLayer

func change_scene(path, _delay = 0.5):
	$transition_fx.interpolate_property($overlay, "progress", 0.0, 1.0, 2.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	$transition_fx.start()
	yield($transition_fx, "tween_completed")
	assert(get_tree().change_scene(path) == OK)
	yield(get_tree().create_timer(0.3), "timeout")
	get_parent().queue_free()
