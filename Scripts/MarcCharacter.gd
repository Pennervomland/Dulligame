extends "res://Scripts/PlayerCharacter.gd"

var salt_level = 0
export var max_salt_level:int = 100
export var saltstorm_damage:int = 20

export var bath_salt_card_amount:int = 2
export var salt_shaker_card_amount:int = 2 
export var salt_in_the_wound_card_amount:int = 2

onready var salt_bar = $Control/SaltBar

onready var bath_salt_card = preload("res://Scenes/BathSaltCard.tscn")
onready var salt_shaker_card = preload("res://Scenes/SaltShakerCard.tscn")
onready var salt_in_the_wound_card = preload("res://Scenes/SaltInTheWoundCard.tscn")

export var ragequit_hp_difference:int = 30
export var salt_after_damage:int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	player_name = "Marc"
	salt_bar.max_value = max_salt_level
	salt_bar.value = salt_level

func add_salt(var salt):
	if salt_level + salt < max_salt_level:
		salt_level = salt_level + salt
	else:
		salt_level = (salt_level + salt) - max_salt_level
		evoke_saltstorm()
	salt_bar.value = salt_level	

func evoke_saltstorm():
	Global.inactive_player.apply_damage(saltstorm_damage)
	Global.ui.set_round_count_label_text("Salzsturm!")

func generate_cards_in_deck(var amount: int):
	generate_attack_card_in_deck()
	generate_healing_card_in_deck()
	generate_mana_card_in_deck()
	generate_attack_card_in_deck()
	generate_attack_card_in_deck()
	generate_attack_card_in_deck()
	generate_special_cards_in_deck()
	

func apply_damage(var damage):
	.apply_damage(damage)
	print(enemy)
	if enemy.hp - hp >= ragequit_hp_difference:
		Global.game.end_game(self)
	add_salt(salt_after_damage)
	
# das var i kann entfernt werden. einfach nur damit n bssl platz zwischen karten vorhanden ist
func generate_special_cards_in_deck():
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	for i in range(0,bath_salt_card_amount):
		var instance = bath_salt_card.instance()
		instance.position = Vector2(-100,viewport.y+100)
		instance.init(self)
		put_card_in_deck(instance)
	
	for i in range(0,salt_shaker_card_amount):
		var instance = salt_shaker_card.instance()
		instance.position = Vector2(-100,viewport.y+100)
		instance.init(self)
		put_card_in_deck(instance)
	
	for i in range(0,salt_in_the_wound_card_amount):
		var instance = salt_in_the_wound_card.instance()
		instance.position = Vector2(-100,viewport.y+100)
		instance.init(self)
		put_card_in_deck(instance)
