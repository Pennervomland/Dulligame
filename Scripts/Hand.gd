extends Node

var cards = []
var card_amount:int = 0

var hand_player1_node
var hand_player2_node

var anim_hand1
var anim_hand2

export var maximal_card_amount:int = 7

#define circle
export var circle_center:Vector2
export var radius:float = 500
export var diff_angle:float = 5


#set_as_toplevel benutzen!!!!!
func init_the_fucking_hand():
	hand_player1_node = Global.player1.get_child(2)
	hand_player2_node = Global.player2.get_child(2)

	
	anim_hand1 = hand_player1_node.get_child(0)
	anim_hand2 = hand_player2_node.get_child(0)
	

func render_new_cards(var new_cards):
	if (new_cards.size() <= maximal_card_amount):
		cards = new_cards
		card_amount = cards.size()
		var params = calc_card_positions()
		apply_new_card_positions(params[0],params[1], params[2])
		if Global.active_player == Global.player1:
			anim_hand1.play()
		else:
			anim_hand2.play()


func apply_new_card_positions(var new_card_positions, var new_card_rotations, var new_card_z_indexes):
	for card_index in range(0,card_amount):
		cards[card_index].global_position = new_card_positions[card_index]
		cards[card_index].rotation_degrees = new_card_rotations[card_index]
		cards[card_index].z_index = new_card_z_indexes[card_index]

func calc_card_positions ():
	
	var new_card_positions = []
	var new_card_rotations = []
	var new_card_z_indexes = []
	
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	circle_center = Vector2(viewport.x/2,viewport.y+490)
	
	var middle_card_index = floor(card_amount/2)
	
	for card_index in range(0,card_amount):
		var new_card_pos:Vector2
		var new_card_rotation:float
		var new_z_index:int
		
		var difference_from_middle_card_index = card_index - middle_card_index
		#var steps_to_right = floor(card_index/2)+1
		#var steps_to_left = floor(card_index/2)
		
		if difference_from_middle_card_index == 0:
			new_card_pos = circle_center + radius * Vector2.UP
			new_card_rotation = 0
			new_z_index = ceil(card_amount/2)
		elif difference_from_middle_card_index > 0:
			var steps_to_right = difference_from_middle_card_index
			var angle_to_right = steps_to_right * diff_angle
			new_z_index = ceil(card_amount/2)+steps_to_right
			var alpha = 90 - angle_to_right
			var direction:Vector2 = Vector2(cos(radian_of(alpha)),-sin(radian_of(alpha)))
			new_card_pos = circle_center + radius * direction
			new_card_rotation = angle_to_right
		else:
			var steps_to_left = -difference_from_middle_card_index
			var angle_to_left = steps_to_left * diff_angle
			new_z_index = ceil(card_amount/2)-steps_to_left
			var beta = 90 + angle_to_left
			var direction:Vector2 = Vector2(cos(radian_of(beta)),-sin(radian_of(beta)))

			new_card_pos = circle_center + radius * direction
			new_card_rotation = -angle_to_left

		new_card_positions.append(new_card_pos)
		new_card_rotations.append(new_card_rotation)
		new_card_z_indexes.append(new_z_index)
		
	return [new_card_positions,new_card_rotations,new_card_z_indexes]

func remove_card(var card_to_remove):
	var card_to_remove_index = get_index_in_card_array(card_to_remove)
	card_to_remove.old_position_in_hand = card_to_remove_index
	
	var params = calc_card_positions()
	
	for i in range(card_to_remove_index,card_amount-1):
		cards[i] = cards[i+1] 
		
	cards[card_amount-1] = null
	
	card_amount = card_amount - 1 

	params = calc_card_positions()
	apply_new_card_positions(params[0],params[1], params[2])


func add_card(var card_to_add):
	var i = card_amount
	while i > card_to_add.old_position_in_hand : 
		cards[i] = cards[i-1]
		i = i - 1

	cards[card_to_add.old_position_in_hand] = card_to_add
	card_amount = card_amount + 1
	
	var params = calc_card_positions()
	apply_new_card_positions(params[0],params[1], params[2])

func get_index_in_card_array(var card):
	for i in range(0,card_amount):
		if (card == cards[i]):
			return i
	return -1


func retrieve_cards():
	var return_array = []
	for card in cards:
		if card!=null:
			return_array.append(card)
	return return_array

func radian_of(var angle_in_degrees):
	return angle_in_degrees * (PI / 180)
