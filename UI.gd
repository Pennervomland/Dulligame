extends Node

onready var mana_label1 = $Player1/ManaPlayer1/ManaLabel1
onready var mana_label2 = $Player2/ManaPlayer2/ManaLabel2

onready var deck_label1 = $Player1/DeckPlayer1/DeckLabel1
onready var deck_label2 = $Player2/DeckPlayer2/DeckLabel2

onready var discard_label1 = $Player1/DiscardPilePlayer1/DiscardLabel1
onready var discard_label2 = $Player2/DiscardPilePlayer2/DiscardLabel2

onready var round_count = $RoundCount

signal end_turn_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	mana_label1.text = str(Global.mana_player1)
	mana_label2.text = str(Global.mana_player2)
	deck_label1.text = str(Global.deck_size_player1)
	deck_label2.text = str(Global.deck_size_player2)
	discard_label1.text = str(Global.discard_pile_size_player1)
	discard_label2.text = str(Global.discard_pile_size_player2)
	round_count.text = str(Global.round_counter)

func _on_EndTurnButton_pressed():
	emit_signal("end_turn_signal")
