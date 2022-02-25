extends "res://Scripts/PlayerCharacter.gd"

var winterfell_card = preload("res://Scenes/WinterfellCard.tscn")
var bodycheck_card = preload("res://Scenes/BodycheckCard.tscn")

onready var six_pack = $Face/SixPack
onready var fett_pack = $Face/FettPack

var bodycheck_dmg:int
var convert_healing_to_armor:bool
var count_down:int
# Called when the node enters the scene tree for the first time.
func _ready():
	six_pack.visible = false
	fett_pack.visible = false
	player_name = "Nils"
	Global.ui.connect("end_turn_signal", self, "count_down_rounds")

func _process(delta):
	if convert_healing_to_armor == false:
		six_pack.visible = false
		fett_pack.visible = false

func apply_damage(var damage):
	.apply_damage(damage)
	do_fett_six_pack_stuff()

func apply_healing(var healing):
	if !convert_healing_to_armor:
		.apply_healing(healing)
	else:
		.apply_armor(healing)
		do_fett_six_pack_stuff()

func do_fett_six_pack_stuff():
	if armor < 10:
		six_pack.visible = true
		fett_pack.visible = false
		fett_pack.scale = Vector2(0.2, 0.3)
	if armor >= 10:
		fett_pack.visible = true
		six_pack.visible = false
		if armor >= 15:
			fett_pack.scale = Vector2(0.25, 0.35)
		if armor >= 20:
			fett_pack.scale = Vector2(0.35, 0.45)

func generate_cards_in_deck(var amount:int):
	for i in range(0,healing_card_amount):
		generate_healing_card_in_deck()
	for i in range(0,mana_card_amount):
		generate_mana_card_in_deck()
	for i in range(0,1):
		generate_winterfell_card()
	for i in range(0,1):
		generate_bodycheck_card()

func calc_schwitzer_damage(var dmg):
	bodycheck_dmg = 0
	bodycheck_dmg = dmg
	if hp_bar.value >= 80:
		bodycheck_dmg *= 1
	elif hp_bar.value >= 50:
		bodycheck_dmg *= 1.2
	elif hp_bar.value > 10:
		bodycheck_dmg *= 1.5
	elif hp_bar.value <= 10:
		bodycheck_dmg *= 2
	return ceil(bodycheck_dmg)

func activate_bodycheck_card():
	Global.inactive_player.apply_damage(calc_schwitzer_damage(armor))

func count_down_rounds():
	if count_down > 0:
		count_down -= 1
	else:
		convert_healing_to_armor = false

func activate_winterfell_card():
	convert_healing_to_armor = true
	count_down = 10 #auf 3 changen
	do_fett_six_pack_stuff()

func generate_bodycheck_card():
	var instance = bodycheck_card.instance()
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	instance.position = Vector2(-100,viewport.y+100)
	instance.init(self)
	put_card_in_deck(instance)

func generate_winterfell_card():
	var instance = winterfell_card.instance()
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	instance.position = Vector2(-100,viewport.y+100)
	instance.init(self)
	put_card_in_deck(instance)
