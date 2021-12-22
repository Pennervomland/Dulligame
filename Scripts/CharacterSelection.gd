extends Node2D

var characters_selected = 0

onready var player_text = $PlayerText


# Called when the node enters the scene tree for the first time.
func _ready():
	characters_selected = 0


func _on_MaxButton_pressed():
	select_character("Max")
	change_player()
	if(characters_selected==2):
		get_tree().change_scene("res://Scenes//Testroom.tscn")


func select_character(var character_name:String):
	if(characters_selected==0):
		Global.selected_character_player1 = character_name
	else:
		Global.selected_character_player2 = character_name
	
func change_player():
	player_text.bbcode_text="[color=green]Player 2[/color]"
	characters_selected +=1
