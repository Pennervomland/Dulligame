extends Node2D


onready var game = get_tree().root.get_child(1)
onready var chat_label = $Communication/Chat/ChatLabel

var start_hp

export var hp = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func put_salt_in_wound():
	chat_label.text = "Ich kann mich eh nicht heilen du kek"
