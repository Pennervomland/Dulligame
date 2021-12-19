extends Node2D

onready var player1_active=true

onready var player1 = $Player1Character
onready var player2 = $Player2Character

var active_player
var turn = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	active_player = player1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func next_turn():
	trigger_permanent_effect()
	swap_active_player()
	turn+=1
	
	


func trigger_permanent_effect():
	pass


	
func swap_active_player():
	if (player1_active):
		player1_active=false
		active_player = player2
	else:
		player1_active=true
		active_player = player1
