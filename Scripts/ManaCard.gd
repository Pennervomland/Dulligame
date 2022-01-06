extends "res://Scripts/Card.gd"

var max_face = preload("res://assets/cards/maxeroo.png")
var fabi_face = preload("res://assets/cards/fabian.png")
var nils_face = preload("res://assets/cards/nils.png")
var dome_face = preload("res://assets/cards/dome.png")
var marc_face = preload("res://assets/cards/marc.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	card_image.modulate = Color(0.2,0.2,1)
	if associated_player.player_name == "Max":
		card_image.texture = max_face
	elif associated_player.player_name == "Fabi":
		card_image.texture = fabi_face
	elif associated_player.player_name == "Nils":
		card_image.texture = nils_face
	elif associated_player.player_name == "Dome":
		card_image.texture = dome_face
	elif associated_player.player_name == "Marc":
		card_image.texture = marc_face
	var card_text = str("Regeneriert ",mana_regeneration, " Mana")
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
	Global.active_player.apply_mana_bonus(mana_regeneration)
	discard_card()
	
