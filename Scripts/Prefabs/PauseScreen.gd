extends Popup

onready var changer_in = get_parent().get_parent().get_node("TransitionIn")

func _ready():
	self.visible = true
	pass

func _on_btn_return_pressed():
	finish()

func _on_btn_menu_pressed():
	finish()
	Global.clean_globals()
	changer_in.change_scene("res://Scenes/Menu.tscn")

func _on_btn_exit_pressed():
	get_tree().quit()


func finish():
	print("Finalizando.....")
	get_tree().paused = false
	queue_free()
	pass
