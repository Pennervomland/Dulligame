extends Node2D

var penguin_mode
var penguin_number
var penguin_master

export var damage:int = 3
export var armor:int = 3

onready var attack_penguin_image = preload("res://assets/cards/specialCards/Fattackuin.png")
onready var defense_penguin_image = preload("res://assets/cards/specialCards/DeFenduin.png")

onready var penguin_image = $PenguinImage

func init(var penguin_mode, var penguin_number, var penguin_master):
	self.penguin_mode = penguin_mode
	self.penguin_number = penguin_number
	self.penguin_master = penguin_master
	change_mode(penguin_mode)

func change_mode (var new_mode):
	penguin_mode = new_mode
	if penguin_mode == "attack":
		penguin_image = attack_penguin_image
	elif penguin_mode == "defense":
		penguin_image = defense_penguin_image


func trigger_effect():
	if penguin_mode == "attack":
		Global.inactive_player.apply_damage(damage)
	elif penguin_mode == "defense":
		penguin_master.apply_armor(armor)
