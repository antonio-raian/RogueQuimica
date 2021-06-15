extends Node

const MAX_HEALTH = 3

var player 

var coins = 0
var gravity = 1200

var lifes = 3

var elements = ["H", "O", "C", "Cl", "Na", "Au", "N", "Fe", "F"]
var scenes_portion = [
	"res://Assets/Itens/Potions/Blue potions/poção azul.png",
	"res://Assets/Itens/Potions/Green potions/poção verde.png",
	"res://Assets/Itens/Potions/Purple potions/poção roxa.png",
	"res://Assets/Itens/Potions/Yellow potions/poção amarela.png"
]
var store = [
	{id=0, sigla=elements[0], name="Hidrogênio", scene=scenes_portion[randi()% scenes_portion.size()], value=10},
	{id=1, sigla=elements[1], name="Oxigênio", scene=scenes_portion[randi()% scenes_portion.size()], value=10},
	{id=2, sigla=elements[2], name="Carbono", scene=scenes_portion[randi()% scenes_portion.size()], value=10},
	{id=3, sigla=elements[3], name="Cloro", scene=scenes_portion[randi()% scenes_portion.size()], value=10},
	{id=4, sigla=elements[4], name="Sódio", scene=scenes_portion[randi()% scenes_portion.size()], value=10},
	{id=5, sigla=elements[5], name="Ouro", scene=scenes_portion[randi()% scenes_portion.size()], value=100},
	{id=6, sigla=elements[6], name="Nitrogênio", scene=scenes_portion[randi()% scenes_portion.size()], value=10},
	{id=7, sigla=elements[7], name="Ferro", scene=scenes_portion[randi()% scenes_portion.size()], value=10},
	{id=8, sigla=elements[8], name="Fluor", scene=scenes_portion[randi()% scenes_portion.size()], value=10},
]

var inventory = []

func _ready():
	randomize()
	lifes = MAX_HEALTH
	pass


func buy_in_store(id):
	add_item(store[id], 1)
	
func add_item(item, quantity):
	var aux = item
	aux["quantity"] = quantity
	print(aux)
	inventory.append(aux)
	
func drop_item(item, quantity):
	var index = inventory.find(item)
	if index > -1:
		if inventory[index].quantity <= quantity:
			inventory.remove(index)
		else:
			inventory[index].quantity -= quantity

func use_item(item, quantity):
	drop_item(item, quantity)
