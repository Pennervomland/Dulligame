extends Node

var cards = []
var card_amount:int = 0

export var maximal_card_amount:int = 7

#define circle

export var circle_center:Vector2
export var radius:float = 500
export var diff_angle:float = 5

func render_new_cards(var new_cards):
	if (new_cards.size() <= maximal_card_amount):
		cards = new_cards
		card_amount = cards.size()
		apply_new_card_positions()
		

func apply_new_card_positions ():
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	circle_center = Vector2(viewport.x/2,viewport.y+490)
	
	for card_index in range(0,card_amount):
		var new_card_pos:Vector2
		var new_card_rotation:float
		var new_z_index:int
		
		if card_index==0:
			new_card_pos = circle_center + radius * Vector2.UP
			new_card_rotation = 0
			new_z_index = ceil(card_amount/2)
		elif card_index %2 == 1:
			var steps_to_right = floor(card_index/2)+1
			var angle_to_right = steps_to_right * diff_angle
			new_z_index = ceil(card_amount/2)+steps_to_right
			var alpha = 90 - angle_to_right
			var direction:Vector2 = Vector2(cos(radian_of(alpha)),-sin(radian_of(alpha)))
			new_card_pos = circle_center + radius * direction
			new_card_rotation = angle_to_right
		else:
			var steps_to_left = floor(card_index/2)
			var angle_to_left = steps_to_left * diff_angle
			new_z_index = ceil(card_amount/2)-steps_to_left
			var beta = 90 + angle_to_left
			var direction:Vector2 = Vector2(cos(radian_of(beta)),-sin(radian_of(beta)))

			new_card_pos = circle_center + radius * direction
			new_card_rotation = -angle_to_left
		

		cards[card_index].position = new_card_pos
		

		cards[card_index].rotation_degrees = new_card_rotation
		
		cards[card_index].z_index = new_z_index


func radian_of(var angle_in_degrees):
	return angle_in_degrees * (PI / 180)
