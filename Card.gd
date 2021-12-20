extends Sprite


export var damage = 10
export var mana_costs = 1
export var healing = 5
export var armor = 3
export var mana_regeneration = 1

var is_mouse_on_card: bool  # When mouse is on the card
var is_card_in_use: bool    # When card is in use meaning another left click would use it
var is_card_in_focus: bool  # When mouse is over the card in players hand

var mouse_pos = get_global_mouse_position()

onready var start_pos = position # Currently a position whereever... Subject to change

# Called when the node enters the scene tree for the first time.
func _ready():
	is_mouse_on_card = false
	is_card_in_use = false
	is_card_in_focus = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Puts card in use (which moves it center of the screen) and puts it out of focus on LMB press
	if(Input.is_action_just_released("LeftMB")== true && is_mouse_on_card==true):
		is_card_in_use = true
		is_card_in_focus = false
		
	#Moves card in center and makes it bigger if in use
	if(is_card_in_use == true):
		scale = Vector2(1,1)
		position = Vector2(512,220)
		#Activates the card
		if(Input.is_action_just_pressed("LeftMB")== true && is_mouse_on_card==true):
			trigger_effect()
		
	#Puts card out of use and puts it back in the hand on RMB press
	if(Input.is_action_just_pressed("RightMB") == true && is_card_in_use == true):
		is_card_in_use = false
		scale = Vector2(0.5,0.5)
		position = start_pos

#Trigger effect (damage/heal/mana_cost) or special effect
func trigger_effect():
	Global.is_card_played = true
	Global.played_card = self
	card_basic_effect(0,0,0,0,0)
	card_special_effect()

func card_basic_effect(var damage:int, var heal:int, var armor:int, var mana_regen:int, var mana_cost):
	Global.damage = damage
	Global.heal = heal
	Global.armor = armor
	Global.mana_regeneration = mana_regen
	Global.mana_cost = mana_cost
	Global.activate_effects()

func card_special_effect():
	pass

#When mouse enters card area collision shape
func _on_Area2D_mouse_entered():
	#Puts card in focus (makes it slightly bigger) if it's not in use
	is_mouse_on_card = true
	if(is_card_in_use == false):
		scale = Vector2(0.75, 0.75)
		is_card_in_focus = true

#When mouse exits card area collision shape
func _on_Area2D_mouse_exited():
	#Puts card out of focus (makes it slightly smaller) if it's not in use
	if(is_card_in_use == false):
		scale = Vector2(0.5,0.5)
	is_mouse_on_card = false
	is_card_in_focus = false
