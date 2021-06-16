extends Node

const MAX_HEALTH = 3
const GRAVITY = 1200

var player 
var coins = 0
var lifes = 3
var inventory = []

var elements = ["H", "O", "C", "Cl", "Na", "Au", "N", "Fe", "F"]
var composites = ["H2O", "CO2", "NaCl"]

var scenes_portion = [
	"res://Assets/Itens/Potions/Blue potions/poção azul.png",
	"res://Assets/Itens/Potions/Green potions/poção verde.png",
	"res://Assets/Itens/Potions/Purple potions/poção roxa.png",
	"res://Assets/Itens/Potions/Yellow potions/poção amarela.png"
]

var periodic_table = [
	{id=0, sigla=elements[0], active=false, name="Hidrogênio", details="O hidrogénio ou hidrogênio é um elemento químico com número atómico ou atômico 1 e representado pelo símbolo H.", scene=scenes_portion[randi()% scenes_portion.size()]},
	{id=1, sigla=elements[1], active=false, name="Oxigênio", details=" Trata-se do elemento mais abundante na superfície terrestre. Todos sabemos da importância vital desse elemento, já que ele forma o gás oxigênio (O2)", scene=scenes_portion[randi()% scenes_portion.size()]},
	{id=2, sigla=elements[2], active=false, name="Carbono", details="O carbono é um elemento químico, símbolo C, sólido à temperatura ambiente.", scene=scenes_portion[randi()% scenes_portion.size()]},
	{id=3, sigla=elements[3], active=false, name="Cloro", details="O cloro é um elemento químico, símbolo Cl. Está contido no grupo dos halogênios e é o segundo halógeno mais leve, após o flúor. Sob condições normais é um gás de coloração amarelo esverdeada", scene=scenes_portion[randi()% scenes_portion.size()]},
	{id=4, sigla=elements[4], active=false, name="Sódio", details="O sódio é um elemento químico de símbolo Na. É um metal alcalino, sólido na temperatura ambiente, macio, untuoso, de coloração branca, ligeiramente prateada.", scene=scenes_portion[randi()% scenes_portion.size()]},
	{id=5, sigla=elements[5], active=false, name="Ouro", details="Na natureza, o ouro é produzido a partir da colisão de duas estrelas de nêutrons. O ouro é utilizado de forma generalizada em joalharia, indústria e eletrônica, bem como reserva de valor.", scene=scenes_portion[randi()% scenes_portion.size()]},
	{id=6, sigla=elements[6], active=false, name="Nitrogênio", details="O nitrogênio (N) é considerado o 7° mais abundante do universo, presente na Via Láctea e no Sistema Solar, além de compor macromoléculas importantes para os seres.", scene=scenes_portion[randi()% scenes_portion.size()]},
	{id=7, sigla=elements[7], active=false, name="Ferro", details="O ferro é um metal obtido em siderúrgicas por meio da hematita, um de seus minérios. Por meio dele é feita a liga de aço, que possui grande aplicação em nossa sociedade.", scene=scenes_portion[randi()% scenes_portion.size()]},
	{id=8, sigla=elements[8], active=false, name="Fluor", details="O flúor é um mineral natural encontrado em toda a crosta terrestre e largamente distribuído pela natureza. Alguns alimentos contêm flúor, assim como a água fornecida por algumas empresas de serviço público.", scene=scenes_portion[randi()% scenes_portion.size()]},
]
var store = []


func _ready():
	randomize()
	clean_globals()
	for i in periodic_table:
		store.append(i)
		store[i.id]["value"] = 1
	pass

func buy_in_store(item):
	if coins >= item.value:
		add_item(item, 1)
		coins -= item.value
	
func add_item(item, quantity):
	var index = inventory.find(item)
	if index > -1:
		inventory[index].quantity += quantity
	else:
		index = periodic_table.find(item)
		if index > -1:
			periodic_table[index].active = true
		var aux = item
		aux["quantity"] = quantity
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

func merge_elements(item1, item2, item3={}):
	match item1.sigla:
		"H":
			if item3 and item3.sigla == "H":
				if item2.sigla == "O":
					add_item({
						id=inventory.size(), 
						sigla=composites[0], 
						name="Água", 
						scene=scenes_portion[randi()% scenes_portion.size()], 
						value=120
						}, 1)
		"C":
			if item3 and item3.sigla == "O":
				if item2.sigla == "O":
					add_item({
						id=inventory.size(), 
						sigla=composites[1], 
						name="Gás Carbônico", 
						scene=scenes_portion[randi()% scenes_portion.size()], 
						value=80
						}, 1)
		"Na":
			if item2.sigla == "Cl":
				add_item({
					id=inventory.size(), 
					sigla=composites[2], 
					name="Cloreto de Sódio", 
					scene=scenes_portion[randi()% scenes_portion.size()], 
					value=20
					}, 1)

func clean_globals():
	player = null
	coins = 0
	lifes = MAX_HEALTH
	inventory = []
