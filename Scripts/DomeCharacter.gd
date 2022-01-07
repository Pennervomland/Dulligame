extends "res://Scripts/PlayerCharacter.gd"

var prev_round_damage:int = 0
var stored_damage:int = 0

var is_bier_buff_active:bool

signal send_stored_damage

onready var passive_smoker_card = preload("res://Scenes/PassivesmokerCard.tscn")
onready var bier_card = preload("res://Scenes/BierCard.tscn")

func _ready():
	if Global.dome_character != null:
		Global.dome_character2 = self
	else:
		Global.dome_character = self
	player_name = "Dome"
	Global.ui.connect("end_turn_signal", self, "dome_passive")

func _process(delta):
	emit_signal("send_stored_damage")
#	if Global.dome_character == self && Global.is_bier_buff_active:
#		is_bier_buff_active = true
#	elif Global.dome_character2 == self && Global.is_bier_buff2_active:
#		is_bier_buff_active = true
#	else:
#		is_bier_buff_active = false
#	if prev_round_damage > 0:
#		print(prev_round_damage, " prev")
#	if stored_damage > 0:
#		print(stored_damage, "stored")

func apply_damage(var damage):
	.apply_damage(damage)
	print("auaua")
	prev_round_damage += damage



func dome_passive():
	if self == Global.active_player:
		stored_damage = prev_round_damage
		prev_round_damage = 0
	else:
		stored_damage = 0
		apply_damage(5)

func generate_cards_in_deck(var amount: int):
	generate_attack_card_in_deck()
	generate_special_cards_in_deck()
	
# das var i kann entfernt werden. einfach nur damit n bssl platz zwischen karten vorhanden ist
func generate_special_cards_in_deck():
	for i in range(0,2):
		generate_passive_smoker_card()
	for i in range(0,2):
		generate_bier_card()

func generate_bier_card():
	var instance = bier_card.instance()
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	instance.position = Vector2(-100,viewport.y+100)
	instance.init(self)
	put_card_in_deck(instance)


func generate_passive_smoker_card():
	var instance = passive_smoker_card.instance()
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	instance.position = Vector2(-100,viewport.y+100)
	instance.init(self)
	put_card_in_deck(instance)
