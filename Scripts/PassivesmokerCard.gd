extends "res://Scripts/Card.gd"

var smoker_damage:int = 0
var bier_buff_multi:int = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.dome_character.connect("send_stored_damage", self, "set_smoker_damage")
	if Global.dome_character2 != null:
		Global.dome_character2.connect("send_stored_damage", self, "set_smoker_damage")
	var card_text = str("Verursache ",smoker_damage," Schaden")
	card_description.text = card_text

func set_smoker_damage():
	if Global.active_player == Global.dome_character:
		if Global.is_bier_buff_active:
			bier_buff_multi = 2
		else:
			bier_buff_multi = 1
		#print("dome hier")
		smoker_damage = floor(Global.active_player.stored_damage*0.5)
		smoker_damage = smoker_damage * bier_buff_multi
		var card_text = str("Verursache ",smoker_damage," Schaden")
		card_description.text = card_text
	elif Global.active_player == Global.dome_character2:
		if Global.is_bier_buff2_active:
			bier_buff_multi = 2
		else:
			bier_buff_multi = 1
		#print("dome2 hier")
		smoker_damage = floor(Global.active_player.stored_damage*0.5)
		smoker_damage = smoker_damage * bier_buff_multi
		var card_text = str("Verursache ",smoker_damage," Schaden")
		card_description.text = card_text

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
	Global.inactive_player.apply_damage(smoker_damage)
	discard_card()
	
