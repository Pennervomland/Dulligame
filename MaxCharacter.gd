extends "res://PlayerCharacter.gd"

var max_card = preload("res://CardMax.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func generate_cards_in_deck(var amount: int):
	for i in range(0,amount):
		generate_max_card_in_deck(i)
		
func generate_max_card_in_deck(var i):
	var instance = max_card.instance()
	if (self.is_player1):
		instance.position = Vector2(300,400)
	else:
		instance.position = Vector2(300,400)
	instance.position.x += i*100
	$Hand.add_child(instance)
	put_card_in_deck(instance)
