extends Node2D

var max_character_scene = preload("res://MaxCharacter.tscn")


onready var is_player1_active=true

onready var player1
onready var player2


var active_player
var inactive_player

var temp_player
var turn = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$UI.connect("end_turn_signal",self,"next_turn")
	generate_characters()
	active_player = player1
	Global.active_player = player1
	inactive_player= player2
	Global.inactive_player= player2


func generate_characters():
	var instance1 = max_character_scene.instance()
	add_child(instance1)
	player1 = instance1
	player1.position = Vector2(200,300)
	
	var instance2 = max_character_scene.instance()
	add_child(instance2)
	player2 = instance2
	player2.position = Vector2(800,300)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func next_turn():
	print("Next turn")
	trigger_permanent_effect()
	swap_active_player()
	turn+=1
	
func get_active_player():
	return active_player


func trigger_permanent_effect():
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
		
