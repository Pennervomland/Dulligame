extends Node2D

var max_character_scene = preload("res://Scenes//MaxCharacter.tscn")
var fabi_character_scene = preload("res://Scenes//FabiCharacter.tscn")
var nils_character_scene = preload("res://Scenes//NilsCharacter.tscn")
var marc_character_scene = preload("res://Scenes//MarcCharacter.tscn")
var dome_character_scene = preload("res://Scenes//DomeCharacter.tscn")
var bot_cyberpenner_scene = preload("res://Scenes/BotCyberpenner.tscn")

onready var position_player1 = $PositionPlayer1
onready var position_player2 = $PositionBot

onready var is_player1_active=true

onready var player1
onready var player2
onready var character1
onready var character2

var active_player
var inactive_player

func _ready():
	
	Global.game = self
	Global.hand = $Hand
	generate_world(Global.world)
	$BotUI.connect("end_turn_signal",self,"next_turn")
	generate_character(Global.selected_character_player1)
	generate_bot()
	Global.active_player = Global.player1
	Global.inactive_player = Global.player2
	active_player = player1
	inactive_player= player2
	player1.init_enemies()
	$Hand.init_the_fucking_hand()
	next_turn()

func generate_world(var world_name):
	if (world_name == "WindowsWorld"):
		$BotUI/Background.texture = load("res://assets/windows_background_pixelart.png")
		$BotUI/Background.scale = Vector2(1.1, 1.1)
	if (world_name == "RooftopWorld"):
		$BotUI/Background.texture = load("res://assets/rooftop.png")

func generate_bot():
	var instance
	instance = bot_cyberpenner_scene.instance()
	add_child(instance)
	character2 = instance
	character2.position = position_player2.position
	character2.is_player1 = false
	player2 = instance
	Global.player2 = instance

func generate_character(var character_name):
	var instance
	# generates character depending on decision 
	# (probably must be extended with more if-statements and corresponding card-names)
	if(character_name == "Max"):
		instance = max_character_scene.instance()
		add_child(instance)
	elif(character_name == "Fabi"):
		instance = fabi_character_scene.instance()
		add_child(instance)
	elif(character_name == "Nils"):
		instance = nils_character_scene.instance()
		add_child(instance)
	elif(character_name == "Marc"):
		instance = marc_character_scene.instance()
		add_child(instance)
	elif(character_name == "Dome"):
		instance = dome_character_scene.instance()
		add_child(instance)
	character1 = instance
	character1.position = position_player1.position
	character1.is_player1 = true
	player1 = instance
	Global.player1 = instance
	character1.generate_cards_in_deck(5)

func next_turn():
	if !Global.is_card_in_use:
		Global.round_counter+=1
		toggle_current_player()
		if(Global.active_player == player1):
			give_active_player_mana()
	else:
		Global.ui.set_round_count_label_text("Karte weg!")

func toggle_current_player():
	Global.active_player.end_turn()
	
	if(Global.round_counter % 2 == 1):
		print("round % = 1")
		Global.active_player = Global.player1
		Global.inactive_player = Global.player2
	elif(Global.round_counter % 2 == 0):
		print("round % = 0")
		Global.active_player = Global.player2
		Global.inactive_player = Global.player1

	var label_text = str(Global.round_counter,": ",Global.active_player.player_name)
	Global.ui.set_round_count_label_text(label_text)
	Global.active_player.begin_turn()

func give_active_player_mana():
	var current_mana_of_active_player = Global.active_player.mana
	var difference = 3 - current_mana_of_active_player
	print("Apply ", difference, " mana")
	Global.active_player.apply_mana_bonus_without_animation(difference)


func end_game(var losing_player):
	print("End game")
	
	var winning_player
	if losing_player == Global.player1:
		winning_player = Global.player2
	else:
		winning_player = Global.player1
	
	winning_player.hide_ui()
	
	
	var label_text = str(losing_player.player_name," lost!")
	Global.ui.set_round_count_label_text(label_text)
	Global.ui.display_end_buttons()
