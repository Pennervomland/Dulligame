extends Sprite

var old_position_in_hand
var associated_player

export var damage = 10
export var mana_costs = 1
export var healing = 5
export var armor = 3
export var mana_regeneration = 1

var is_mouse_on_card: bool  # When mouse is on the card
var is_card_in_use: bool    # When card is in use meaning another left click would use it
var is_card_in_focus: bool  # When mouse is over the card in players hand

onready var card_image = $CardImage
onready var card_description = $CardDescription

onready var start_pos = position # Currently a position whereever... Subject to change

# Called when the node enters the scene tree for the first time.
func _ready():
	$Mana/ManaCost.text = str(mana_costs)
	is_mouse_on_card = false
	is_card_in_use = false
	is_card_in_focus = false

func init(var associated_player):
	self.associated_player = associated_player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Puts card in use (which moves it center of the screen) and puts it out of focus on LMB press
	if(Input.is_action_just_released("LeftMB")== true && is_mouse_on_card==true && !Global.is_card_in_use):
		print(self)
		self.rotation_degrees = 0
		is_card_in_use = true
		Global.is_card_in_use = true
		is_card_in_focus = false
		Global.hand.remove_card(self)
		
		
	#Puts card out of use and puts it back in the hand on RMB press
	if(Input.is_action_just_pressed("RightMB") == true && is_card_in_use == true):
		is_card_in_use = false
		Global.is_card_in_use = false
		scale = Vector2(0.5,0.5)
		position = start_pos
		Global.hand.add_card(self)
	


func card_basic_effect():
	#is not the child class. COULD CAUSE PROBLEM
	Global.played_card = self
	Global.active_player.apply_mana_costs(mana_costs)


#When mouse enters card area collision shape
func _on_Area2D_mouse_entered():
	#Puts card in focus (makes it slightly bigger) if it's not in use
	is_mouse_on_card = true
	if !Global.is_card_in_use:
		if(is_card_in_use == false):
			Global.insert(self)
			if(Global.card_in_focus_array[0] == self):
				is_card_in_focus = true
				scale = Vector2(0.75, 0.75)

#When mouse exits card area collision shape
func _on_Area2D_mouse_exited():
	#Puts card out of focus (makes it slightly smaller) if it's not in use
	Global.delete(self)
	if(!is_card_in_use):
		scale = Vector2(0.5, 0.5)
	is_card_in_focus = false
	is_mouse_on_card = false
	
	

func discard_card():
	is_card_in_use = false
	
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	self.position = Vector2(-200,viewport.y+300)
	
	Global.active_player.put_card_to_discard_pile(self)
	
