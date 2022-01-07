extends "res://Scripts/PlayerCharacter.gd"

var winterfell_card = preload("res://Scenes/WinterfellCard.tscn")

var convert_healing_to_armor:bool
var count_down
# Called when the node enters the scene tree for the first time.
func _ready():
	player_name = "Nils"

func apply_healing(var healing):
	if convert_healing_to_armor:
		.apply_healing(healing)
	else:
		.apply_armor(healing)

func generate_cards_in_deck(var amount:int):
	for i in range(0,2):
		generate_healing_card_in_deck()
	for i in range(0,3):
		generate_winterfell_card()
func activate_winterfell_card():
	pass
	
func generate_winterfell_card():
	var instance = winterfell_card.instance()
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	instance.position = Vector2(-100,viewport.y+100)
	instance.init(self)
	put_card_in_deck(instance)
