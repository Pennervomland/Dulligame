extends Node2D


func _on_BotButton_pressed():
	Global.mode = "BotMode"
	get_tree().change_scene("res://Scenes/WorldSelect.tscn")


func _on_PvPButton_pressed():
	Global.mode = "PvPMode"
	get_tree().change_scene("res://Scenes/WorldSelect.tscn")
