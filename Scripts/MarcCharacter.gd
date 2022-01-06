extends "res://Scripts/PlayerCharacter.gd"

var salt_level = 0
export var max_salt_level = 100
export var saltstorm_damage = 20

export var bath_salt_card_amount = 2
export var salt_shaker_card_amount = 2 

onready var salt_bar = $Control/SaltBar

onready var bath_salt_card = preload("res://Scenes/BathSaltCard.tscn")
onready var salt_shaker_card = preload("res://Scenes/SaltShakerCard.tscn")

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
	
	
# das var i kann entfernt werden. einfach nur damit n bssl platz zwischen karten vorhanden ist
func generate_special_cards_in_deck():
	for i in range(0,bath_salt_card_amount):
		var instance = bath_salt_card.instance()
		var viewport:Vector2 = get_viewport().get_visible_rect().size 
		instance.position = Vector2(-100,viewport.y+100)
		instance.init(self)
		put_card_in_deck(instance)
	
	for i in range(0,salt_shaker_card_amount):
		var instance = salt_shaker_card.instance()
		var viewport:Vector2 = get_viewport().get_visible_rect().size 
		instance.position = Vector2(-100,viewport.y+100)
		instance.init(self)
		put_card_in_deck(instance)
