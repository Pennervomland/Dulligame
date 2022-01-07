extends "res://Scripts/PlayerCharacter.gd"

export var max_penguin_amount:int = 10
export var max_fattackuin_card_amount:int = 5
export var max_defenduin_card_amount:int = 5 

export var new_penguin_card_amount:int = 5

onready var penguin_scene = preload("res://Scenes/Penguin.tscn")
onready var new_penguin_card = preload("res://Scenes/NewPenguinCard.tscn")
onready var defenduin_card = preload("res://Scenes/ChangeToDefenduinCard.tscn")
onready var fattackuin_card = preload("res://Scenes/ChangeToFattackuinCard.tscn")

var penguins = []

onready var penguin_pos1 = $PenguinPositions/PenguinPos1
onready var penguin_pos2 = $PenguinPositions/PenguinPos2
onready var penguin_pos3 = $PenguinPositions/PenguinPos3
onready var penguin_pos4 = $PenguinPositions/PenguinPos4
onready var penguin_pos5 = $PenguinPositions/PenguinPos5
onready var penguin_pos6 = $PenguinPositions/PenguinPos6
onready var penguin_pos7 = $PenguinPositions/PenguinPos7
onready var penguin_pos8 = $PenguinPositions/PenguinPos8
onready var penguin_pos9 = $PenguinPositions/PenguinPos9
onready var penguin_pos10 = $PenguinPositions/PenguinPos10

var penguin_positions = []

# Called when the node enters the scene tree for the first time.
func _ready():
	player_name = "Fabi"
	for i in range(1,11):
		var var_name = str("penguin_pos",i)
		penguin_positions.append(get(var_name))
	print(penguin_positions)

func generate_cards_in_deck(var amount: int):
	generate_special_cards_in_deck()
	

func generate_special_cards_in_deck():
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	var instance
	for i in range(0,new_penguin_card_amount):
		instance = new_penguin_card.instance()
		instance.position = Vector2(-100,viewport.y+100)
		instance.init(self)
		put_card_in_deck(instance)
	for i in range(0, max_fattackuin_card_amount):
		instance = fattackuin_card.instance()
		instance.position = Vector2(-100,viewport.y+100)
		instance.init(self)
		put_card_in_deck(instance)
	for i in range(0, max_defenduin_card_amount):
		instance = defenduin_card.instance()
		instance.position = Vector2(-100,viewport.y+100)
		instance.init(self)
		put_card_in_deck(instance)
		
		

func add_penguin(var penguin_mode):
	if penguins.size() < max_penguin_amount:
		var instance = penguin_scene.instance()
		self.add_child(instance)
		var viewport:Vector2 = get_viewport().get_visible_rect().size 
		instance.global_position = calc_penguin_position(penguins.size())
		if !is_player1:
			instance.global_position.x = instance.global_position.x + (Global.player2.position.x - Global.player1.position.x)
		instance.init(penguin_mode, penguins.size(),self)
		penguins.append(instance)
	else:
		Global.ui.set_round_count_label_text("Zu viele Pinguin")
	
func calc_penguin_position (var penguin_id):
	return penguin_positions[penguin_id].position
	
	
func change_mode_of_all_penguins(var penguin_mode):
	for penguin in penguins:
		penguin.change_mode_temporarily(penguin_mode)


func end_turn():
	for penguin in penguins:
		penguin.trigger_effect()
	for penguin in penguins:
		penguin.restore_mode()
	.end_turn()
