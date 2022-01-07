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
var game
var ui

var dome_character
var dome_character2
var is_bier_buff_active:bool
var is_bier_buff2_active:bool
var round_bier_buff_ends:int
var round_bier_buff2_ends:int

var played_card

var active_player
var inactive_player

var hand
var is_card_in_use:bool = false

func _process(delta):
	for i in range(1,card_in_focus_array.size()):
		card_in_focus_array[i].scale= Vector2(0.5,0.5)

func insert(var card):
	
	card_in_focus_array.append(card)
	card_in_focus_array.sort_custom(self, "sorting_function")

func delete(var card):
	card_in_focus_array.erase(card)
	card_in_focus_array.sort_custom(self, "sorting_function")
	if(card_in_focus_array.size()>0):
		card_in_focus_array[0].scale = Vector2(0.75,0.75)
	
	
func sorting_function(var card_a, var card_b):
	if(card_a.z_index > card_b.z_index):
		return true
	else:
		return false






