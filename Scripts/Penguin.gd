extends Node2D

var penguin_mode
var penguin_number
var penguin_master

export var damage:int = 3
export var armor:int = 3

onready var attack_penguin_image = preload("res://assets/cards/specialCards/Fattackuin.png")
onready var defense_penguin_image = preload("res://assets/cards/specialCards/DeFenduin.png")

onready var penguin_image = $PenguinImage

var old_mode

func init(var penguin_mode, var penguin_number, var penguin_master):
	print(get_parent())
	self.scale = Vector2(0.15,0.15)
	self.penguin_mode = penguin_mode
	self.penguin_number = penguin_number
	self.penguin_master = penguin_master
	old_mode = penguin_mode
	change_mode(penguin_mode)

func change_mode (var new_mode):
	penguin_mode = new_mode
	if penguin_mode == "attack":
		penguin_image.texture = attack_penguin_image
	elif penguin_mode == "defense":
		penguin_image.texture = defense_penguin_image


func change_mode_temporarily(var temp_mode):
	penguin_mode = temp_mode
	change_mode(penguin_mode)
	

func restore_mode():
	penguin_mode = old_mode
	change_mode(penguin_mode)

func trigger_effect():
	if penguin_mode == "attack":
		Global.inactive_player.apply_damage(damage)
	elif penguin_mode == "defense":
		penguin_master.apply_armor(armor)
