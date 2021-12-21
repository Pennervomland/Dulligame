extends Node2D

var max_character_scene = preload("res://MaxCharacter.tscn")

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
	$UI.connect("end_turn_signal",self,"next_turn")
	active_player = player1
	Global.active_player = player1
	inactive_player= player2
	Global.inactive_player= player2
	generate_character(Global.selected_character_player1)
	generate_character(Global.selected_character_player2)

#generates characters for each player
func generate_character(var character_name):
	var instance
	if(character_name == "Max"):
		print("halo")
		instance = max_character_scene.instance()
		add_child(instance)
	if(generated_character_count==0):
		print("hallo1")
		character1 = instance
		character1.position = position_player1.position
		generated_character_count += 1
	else:
		print("hallo2")
		character2 =instance
		character2.position = position_player2.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func next_turn():
	print("Next turn")
	trigger_permanent_effect()
	swap_active_player()
	Global.round_counter+=1
	
func get_active_player():
	return active_player


func trigger_permanent_effect():
	pass

func toggle_deck_visibility(var player):
	pass
	
	
func swap_active_player():
	if (is_player1_active):
		is_player1_active=false
		active_player = player2
		Global.active_player = player2
		inactive_player = player1
		Global.inactive_player = player1
	else:
		is_player1_active=true
		active_player = player1
		Global.active_player = player1
		inactive_player = player2
		Global.inactive_player = player2
		
