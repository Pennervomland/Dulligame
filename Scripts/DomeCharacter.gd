extends "res://Scripts/PlayerCharacter.gd"

var prev_round_damage:int = 0
var stored_damage:int = 0

signal send_stored_damage

onready var passive_smoker_card = preload("res://Scenes/PassivesmokerCard.tscn")

func _ready():
	Global.dome_character = self
	player_name = "Dome"
	Global.ui.connect("end_turn_signal", self, "reset_stored_damage")
	Global.ui.connect("end_turn_signal", self, "deal_self_damage")

func _process(delta):
	pass
#	if prev_round_damage > 0:
#		print(prev_round_damage, " prev")
#	if stored_damage > 0:
#		print(stored_damage, "stored")

func apply_damage(var damage):
	.apply_damage(damage)
	prev_round_damage += damage

func deal_self_damage():
	if self == Global.inactive_player:
		apply_damage(5)

func reset_stored_damage():
	if self == Global.active_player:
		stored_damage = prev_round_damage
		prev_round_damage = 0
	else:
		stored_damage = 0
	emit_signal("send_stored_damage")

func generate_cards_in_deck(var amount: int):
	generate_attack_card_in_deck()
	generate_healing_card_in_deck()
	generate_mana_card_in_deck()
	generate_special_cards_in_deck()
	
# das var i kann entfernt werden. einfach nur damit n bssl platz zwischen karten vorhanden ist
func generate_special_cards_in_deck():
	for i in range(0,5):
		generate_passive_smoker_card()

func generate_passive_smoker_card():
		var instance = passive_smoker_card.instance()
		var viewport:Vector2 = get_viewport().get_visible_rect().size 
		instance.position = Vector2(-100,viewport.y+100)
		instance.init(self)
		instance.smoker_damage = stored_damage
		put_card_in_deck(instance)
