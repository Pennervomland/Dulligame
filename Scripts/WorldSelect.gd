extends Node2D




func _on_WindowsWorld_pressed():
	Global.world = "WindowsWorld"
	get_tree().change_scene("res://Scenes/CharacterSelection.tscn")

func _on_RooftopWorld_pressed():
	Global.world = "RooftopWorld"
	get_tree().change_scene("res://Scenes/CharacterSelection.tscn")
	
