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

onready var round_counter = 1

var player1
var player2
var played_card
var active_player
var inactive_player

var hand


