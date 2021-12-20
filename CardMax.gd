extends "res://Card.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	#Moves card in center and makes it bigger if in use
	if(is_card_in_use):
		scale = Vector2(1,1)
		position = Vector2(512,220)
		#Activates the card
		if(Input.is_action_just_pressed("LeftMB") && is_mouse_on_card):
			trigger_effect()
			
	
	
#Trigger effect (damage/heal/mana_cost) or special effect
func trigger_effect():
	card_basic_effect()
	Global.inactive_player.apply_damage(10)
	discard_card()
	
