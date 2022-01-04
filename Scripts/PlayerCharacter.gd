extends Sprite

onready var game = get_tree().root.get_child(1)
export var max_cards_on_hand:int = 5

onready var hp = 100
onready var armor = 0 
onready var mana = 3

var is_player1:bool

var deck_size
var deck = []

var player_hand = []
var player_hand_node

var discard_pile_size
var discard_pile = []

onready var player_ui_node = $Control
onready var hp_bar = $Control/ProgressBar
onready var armor_label = $Control/ArmorSymbol/ArmorLabel
onready var player_hand_node_animator = $PlayerHand/AnimationPlayer

var dead = false


# Called when the node enters the scene tree for the first time.
func _ready():
	#game.connect("player_turn_assign", self, "turn_assign")
	hp_bar.value = hp
	armor_label.text = str(armor)
	player_hand_node = $PlayerHand
	
	var viewport:Vector2 = get_viewport().get_visible_rect().size
	player_hand_node.position = Vector2(0,0)
	

func apply_damage(var damage):
	hp = hp - damage
	if (hp <= 0):
		hp = 0
		player_ui_node.visible = false
		player_hand_node.visible = false
		dead = true
		#rotation = 90
		Global.game.end_game(self)
		
	if is_player1:
		print("Player1 Hp abgezogen")
		Global.hp_player1 = hp
	else:
		print("Player2 Hp abgezogen")
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
		print("player1 mana abgezogen")
		Global.mana_player1 = mana
	else:
		print("player2 mana abgezogen")
		Global.mana_player2 = mana
	

func apply_mana_bonus(var mana_bonus):
	mana = mana + mana_bonus
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


func refill_deck_from_discard_pile():
	print("Size of discard pile: ",discard_pile.size())
	print("Discard pile: ",discard_pile)
	
	var some_constant = discard_pile.size()
	
	for card_index in range(0,some_constant):
		var card = discard_pile[0]
		discard_pile.erase(card)
		discard_pile_size -= 1
		
		if is_player1:
			Global.discard_pile_size_player1 = discard_pile_size
		else:
			Global.discard_pile_size_player2 = discard_pile_size
		
		deck.append(card)
		if is_player1:
			Global.deck_size_player1 += 1
			print("put card from discard to deck")
		else:
			Global.deck_size_player2 += 1

func begin_turn():
	if !is_player1:
		print("Begin: Cards in hand of player 2: ",player_hand.size())
	
	var card_amount_in_player_hand = player_hand.size()
	var difference = max_cards_on_hand - card_amount_in_player_hand
	
	if difference > deck.size():
		refill_deck_from_discard_pile()
	
	for i in range(0,difference):
		draw_card_from_deck()
	Global.hand.render_new_cards(player_hand)
	player_hand_node_animator.play("MovePlayerHandUp")
	
func end_turn():
	if !is_player1:
		print(player_hand)
		print("End: Cards in hand of player 2: ",player_hand.size())
	
	player_hand = Global.hand.retrieve_cards()
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	#print("Player hand: ",player_hand)
	for card in player_hand:
		card.position = Vector2(-100,viewport.y+100)


func draw_card_from_deck():
	var deck_size = deck.size()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_number = rng.randi_range(0,deck_size-1)
	var selected_card = deck[random_number]
	
	deck.erase(selected_card)
	if is_player1:
		Global.deck_size_player1 -= 1
	else:
		Global.deck_size_player2 -=1
		
	player_hand.append(selected_card)
	player_hand_node.add_child(selected_card)


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
		

