extends Node

var is_card_on_character:bool=true;

export var damage:int= 0;
export var heal:int= 0;
export var mana_regeneration:int= 0;

func _ready():
	is_card_on_character=false

func _process(delta):
	pass
