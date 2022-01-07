extends "res://Scripts/Card.gd"

var count_down:int = 0

func _ready():
	Global.ui.connect("end_turn_signal", self, "count_down_rounds")

func count_down_rounds():
	if count_down > 0:
		count_down -= 1

func _process(delta):
	if count_down <= 0:
		Global.active_player.convert_healing_to_armor = false
	#Moves card in center and makes it bigger if in use
	if(is_card_in_use):
		scale = Vector2(1,1)
		
		var viewport:Vector2 = get_viewport().get_visible_rect().size 
		global_position = Vector2(viewport.x/2,viewport.y/2)
		#Activates the card
		if(Input.is_action_just_pressed("LeftMB") && is_mouse_on_card && mana_costs <= Global.active_player.mana):
			print(Global.active_player)
			is_card_in_use = false
			is_card_in_focus = false
			Global.is_card_in_use = false
			trigger_effect()
			
	
	
#Trigger effect (damage/heal/mana_cost) or special effect
func trigger_effect():
	card_basic_effect()
	count_down = 2
	Global.active_player.convert_healing_to_armor = true
	discard_card()
	
