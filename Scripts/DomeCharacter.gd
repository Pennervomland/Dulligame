extends "res://Scripts/PlayerCharacter.gd"

var prev_round_damage:int = 0
var current_round:int
var prev_round:int

func _ready():
	player_name = "Dome"
	Global.ui.connect("end_turn_signal", self, "prev_round_damage_calc")

func _process(delta):
	pass

func apply_damage(var damage):
	.apply_damage(damage)
	prev_round_damage += damage

func prev_round_damage_calc():
	pass

func generate_cards_in_deck(var amount: int):
	pass
#	generate_attack_card_in_deck()
#	generate_healing_card_in_deck()
#	generate_mana_card_in_deck()
#	generate_attack_card_in_deck()
#	generate_attack_card_in_deck()
#	generate_attack_card_in_deck()
	
# das var i kann entfernt werden. einfach nur damit n bssl platz zwischen karten vorhanden ist
func generate_marc_card_in_deck():
	pass
	#var instance = marc_card.instance()
	#var viewport:Vector2 = get_viewport().get_visible_rect().size 
	#instance.position = Vector2(-100,viewport.y+100)
	#instance.init(self)
	#put_card_in_deck(instance)
	
