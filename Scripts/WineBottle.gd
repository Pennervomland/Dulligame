extends "res://Scripts/Card.gd"


func _process(delta):
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
	is_card_in_use = false
	
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	self.position = Vector2(-200,viewport.y+300)
	
