extends Node2D

var max_character_scene = preload("res://Scenes//MaxCharacter.tscn")

signal player_turn_assign

onready var position_player1 = $PositionPlayer1
onready var position_player2 = $PositionPlayer2

onready var is_player1_active=true

onready var player1
onready var player2
onready var character1
onready var character2

var active_player
var inactive_player
var generated_character_count = 0

var temp_player


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.hand = $Hand
	toggle_current_player()
	$UI.connect("end_turn_signal",self,"next_turn")
	generate_character(Global.selected_character_player1)
	generate_character(Global.selected_character_player2)
	Global.active_player = Global.player1
	Global.inactive_player = Global.player2
	active_player = player1
	inactive_player= player2
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#generates characters for each player
func generate_character(var character_name):
	var instance
	# generates character depending on decision 
	# (probably must be extended with more if-statements and corresponding card-names)
	if(character_name == "Max"):
		instance = max_character_scene.instance()
		add_child(instance)
	if(generated_character_count==0):
		character1 = instance
		character1.position = position_player1.position
		character1.is_player1 = true
		player1 = instance
		Global.player1 = instance
		character1.generate_cards_in_deck(5)
		generated_character_count += 1
		
	else:
		character2 =instance
		character2.position = position_player2.position
		character2.is_player1 = false
		player2 = instance
		Global.player2 = instance
		character2.generate_cards_in_deck(2)
		

func toggle_current_player():
	if(Global.round_counter % 2 == 1):
		print("round % = 1")
		Global.active_player = Global.player1
		Global.inactive_player = Global.player2
	elif(Global.round_counter % 2 == 0):
		print("round % = 0")
		Global.active_player = Global.player2
		Global.inactive_player = Global.player1

func next_turn():
	print("Next turn")
	trigger_permanent_effect()
	Global.round_counter+=1
	toggle_current_player()
	emit_signal("player_turn_assign")



func trigger_permanent_effect():
	pass
