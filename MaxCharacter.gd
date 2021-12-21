extends "res://PlayerCharacter.gd"

var max_card = preload("res://CardMax.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	init(true)


func init(var is_player1):
	generate_cards_in_deck()
	
	#TODO: Substitute true with is_player1
	init_generic_character(true)


func generate_cards_in_deck():
	for i in range(0,5):
		var instance = max_card.instance()
		instance.position = Vector2(512,1000)
		instance.position.x += i*100
		$Deck.add_child(instance)
		put_card_in_deck(instance)
