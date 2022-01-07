extends "res://Scripts//PlayerCharacter.gd"

var max_card = preload("res://Scenes//CardMax.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	player_name = "Max"


func generate_cards_in_deck(var amount: int):
	generate_attack_card_in_deck()
	generate_healing_card_in_deck()
	generate_mana_card_in_deck()
	generate_armor_card_in_deck()
	generate_armor_card_in_deck()
	generate_armor_card_in_deck()
	generate_wine_market_card_in_deck()
	generate_wine_market_card_in_deck()
	generate_wine_market_card_in_deck()
	generate_wine_market_card_in_deck()
		
	#dreckig
	#if is_player1:
	#	Global.hand.render_new_cards(deck)
	
# das var i kann entfernt werden. einfach nur damit n bssl platz zwischen karten vorhanden ist
func generate_max_card_in_deck():
	var instance = max_card.instance()
	#get_tree().root.get_child(1).get_child(3).add_child(instance)
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	instance.position = Vector2(-100,viewport.y+100)
	instance.init(self)
	put_card_in_deck(instance)
	


