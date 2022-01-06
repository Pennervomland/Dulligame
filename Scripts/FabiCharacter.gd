extends "res://Scripts/PlayerCharacter.gd"

export var max_penguin_amount:int = 10

onready var penguin_scene = preload("res://Scenes/Penguin.tscn")

var penguins = []


# Called when the node enters the scene tree for the first time.
func _ready():
	player_name = "Fabi"


func generate_cards_in_deck(var amount: int):
	for i in range(0,amount):
		generate_healing_card_in_deck()

	
func add_penguin(var penguin_mode):
	if penguins.size() < max_penguin_amount:
		var instance = penguin_scene.instance()
		var viewport:Vector2 = get_viewport().get_visible_rect().size 
		instance.position = calc_penguin_position(penguins.size())
		instance.init(penguin_mode, penguins.size(),self)
		penguins.append(instance)
	else:
		Global.ui.set_round_count_label_text("Zu viele Pinguin")
	
func calc_penguin_position (var penguin_id):
	pass
	
	
func change_mode_of_all_penguins(var penguin_mode):
	for penguin in penguins:
		penguin.change_mode(penguin_mode)


