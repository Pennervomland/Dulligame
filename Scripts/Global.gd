extends Node

onready var hp_player1 = 100
onready var armor_player1 = 0 
onready var mana_player1 = 3
onready var deck_size_player1 = 0
onready var discard_pile_size_player1 = 0
onready var selected_character_player1

onready var hp_player2 = 100
onready var armor_player2 = 0 
onready var mana_player2 = 3
onready var deck_size_player2 = 0
onready var discard_pile_size_player2 = 0
onready var selected_character_player2

onready var card_in_focus_array = []
onready var mouse_on_cards_amount:int = 0
onready var mouse_on_multiple_cards:bool = false

onready var round_counter = 0
	
var player1
var player2
var played_card
var active_player
var inactive_player

var hand

func insert(var card):
	card_in_focus_array.append(card)
	card_in_focus_array.sort_custom(self, "sorting_function")

func delete(var card):
	card_in_focus_array.erase(card)
	card_in_focus_array.sort_custom(self, "sorting_function")
	
	
func sorting_function(var card_a, var card_b):
	if(card_a.z_index < card_b.z_index):
		return true
	else:
		return false






