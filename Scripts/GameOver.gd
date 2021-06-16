extends CanvasLayer

func _ready():
	pass


func _on_BtnRetry_pressed():
	var coins = Global.coins
	Global.clean_globals()
	Global.coins = coins - 10 if coins - 10 >=0 else 0
	get_tree().change_scene("res://Scenes/Lobby.tscn")
