extends Node

onready var mana_label1 = $Player1/ManaPlayer1/ManaLabel1

onready var deck_label1 = $Player1/DeckPlayer1/DeckLabel1

onready var discard_label1 = $Player1/DiscardPilePlayer1/DiscardLabel1

onready var round_count = $CenterContainer/RoundCount

onready var main_menu_button = $MainMenuButton

signal end_turn_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ui = self
	main_menu_button.visible = false


func _process(delta):
	mana_label1.text = str(Global.mana_player1)
	deck_label1.text = str(Global.deck_size_player1)
	discard_label1.text = str(Global.discard_pile_size_player1)

func set_round_count_label_text (var text):
	round_count.text = str(text)

func display_end_buttons():
	main_menu_button.visible = true


func _on_EndTurnButton_pressed():
	emit_signal("end_turn_signal")
	


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://Scenes//CharacterSelection.tscn")
