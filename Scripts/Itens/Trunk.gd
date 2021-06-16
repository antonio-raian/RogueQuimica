extends Area2D

export(Array, PackedScene) var portion_instance
export (int, 0, 10, 1) var portions = 0

onready var spaw = $spaw

func _input(event):
	if event.is_action_pressed("interation"):
		if get_overlapping_bodies().size() > 0:
			open_trunk()
			
func open_trunk():
	if portions > 0:
		portions -= 1
		$animation.play("opening")

func _on_animation_animation_finished(anim_name):
	if portions > 0 and anim_name == "opening":
		$animation.play("closing")
		

func create_portion():
	var portion_index = round(rand_range(0, portion_instance.size()-1))
	var portion = portion_instance[portion_index].instance()
	
	portion.global_position = spaw.global_position
	portion.apply_impulse(Vector2.ZERO, Vector2(rand_range(150, -150), -100))
	get_parent().call_deferred("add_child", portion)


func _on_Trunk_body_entered(body):
	print(body.name)
	print(get_overlapping_bodies().size())
	
