extends Label

func _process(_delta):
	text = "000" + str(Global.coins)
	if Global.coins >=10:
		text = "00" + str(Global.coins)
	
	if Global.coins >=100:
		text = "0" + str(Global.coins)
		
	if Global.coins >=1000:
		text = str(Global.coins)
