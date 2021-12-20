extends Node

var is_card_played:bool = false
var played_card
var active_player
var inactive_player

var damage:int= 0;
var heal:int= 0;
var armor:int= 0;
var mana_regeneration:int= 0;
var mana_cost: int= 0;


func _ready():
	is_card_played = false

func _process(delta):
	if(is_card_played == true):
		pass

func activate_effects():
	inactive_player.hp_bar -= damage
