extends "res://Scripts/PlayerCharacter.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	player_name = "Nils"


func generate_cards_in_deck(var amount: int):
	for i in range(0,amount):
		generate_healing_card_in_deck()
