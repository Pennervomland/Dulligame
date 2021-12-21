extends Sprite

onready var hp = 100
onready var armor = 0 
onready var mana = 3

var is_player1

var deck_size
var deck = []

var discard_pile_size
var discard_pile = []

onready var hp_bar = $Control/ProgressBar
onready var armor_label = $Control/ArmorSymbol/ArmorLabel

var dead = false


# Called when the node enters the scene tree for the first time.
func _ready():
	hp_bar.value = hp
	armor_label.text = str(armor)
	
# Gets called in inheriting classes/nodes
func init_generic_character(var is_player1_temp):
	is_player1 = is_player1_temp
	deck_size = deck.size()
	discard_pile_size = discard_pile.size()
	if is_player1:
		Global.hp_player1 = hp
		Global.armor_player1 = armor
		Global.mana_player1 = mana
		Global.deck_size_player1 = deck_size
		Global.discard_pile_size_player1 = discard_pile_size
		Global.active_player = self
	else:
		Global.hp_player2 = hp
		Global.armor_player2 = armor
		Global.mana_player2 = mana
		Global.deck_size_player2 = deck_size
		Global.discard_pile_size_player2 = discard_pile_size
		Global.inactive_player = self
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(hp_bar.value <= 0 && dead == false):
		rotation = 90
		dead = true



func apply_damage(var damage):
	hp = hp - damage
	if is_player1:
		Global.hp_player1 = hp
	else:
		Global.hp_player2 = hp
	hp_bar.value = hp
	

func apply_healing(var healing):
	hp = hp + healing
	if is_player1:
		Global.hp_player1 = hp
	else:
		Global.hp_player2 = hp
	hp_bar.value = hp
	

func apply_mana_costs(var mana_costs):
	mana = mana - mana_costs
	if is_player1:
		Global.mana_player1 = mana
	else:
		Global.mana_player2 = mana
	

func apply_mana_bonus(var mana_bonus):
	mana = mana - mana_bonus
	if is_player1:
		Global.mana_player1 = mana
	else:
		Global.mana_player2 = mana


func apply_armor(var armor_difference):
	armor = armor + armor_difference
	if is_player1:
		Global.armor_player1 = armor
	else:
		Global.armor_player2 = armor
	armor_label.text = str(armor)


func put_card_in_deck(var card):
	deck.append(card)
	deck_size = deck.size()
	if is_player1:
		Global.deck_size_player1 = deck_size
	else:
		Global.deck_size_player2 = deck_size
		

func put_card_to_discard_pile(var card):
		
	discard_pile.append(card)
	discard_pile_size = discard_pile.size()
	if is_player1:
		Global.discard_pile_size_player1 = discard_pile_size
	else:
		Global.discard_pile_size_player2 = discard_pile_size
		
	deck.erase(card)
	deck_size = deck.size()
	if is_player1:
		Global.deck_size_player1 = deck_size
	else:
		Global.deck_size_player2 = deck_size
		

