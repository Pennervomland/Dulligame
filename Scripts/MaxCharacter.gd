extends "res://Scripts//PlayerCharacter.gd"

var afk_card = preload("res://Scenes/AFKCard.tscn")
var nicos_help_card = preload("res://Scenes/NicosHelpCard.tscn")
var jaegermeister_card = preload("res://Scenes/NicosHelpCard.tscn") 

var is_too_late = false
var is_nico_active = false
var is_afk = false
var goes_afk_next_round = false

export var afk_card_amount:int = 5
export var nicos_help_card_amount:int = 1
export var jaegermeister_card_amount:int = 5


export var nico_max_damage: int = 30
export var nico_start_damgage:int = 2

var nico_damage
var afk_healing_bonus

# Called when the node enters the scene tree for the first time.
func _ready():
	player_name = "Max"
	nico_damage = nico_start_damgage


func begin_turn():
	if !is_afk:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var random_number = rng.randi_range(0,20)
		if random_number == 0:
			is_too_late = true
			Global.ui.set_round_count_label_text("Max ist zu spät.")
		.begin_turn()
		if is_too_late:
			apply_mana_costs(1)
	else:
		is_afk = false
		apply_healing(afk_healing_bonus)
		Global.game.next_turn()
		


func end_turn():
	if goes_afk_next_round:
		is_afk = true
		goes_afk_next_round = false
	.end_turn()


func get_nico():
	is_nico_active = true

func give_nico_jaegermeister(var jaegermeister_buff):
	if is_nico_active:
		if nico_damage + jaegermeister_buff < nico_max_damage:
			nico_damage = nico_damage + jaegermeister_buff 
			Global.ui.set_round_count_ldabel_text("Nico gebufft")
		else: 
			nico_damage = nico_max_damage
			Global.ui.set_round_count_label_text("Nicos maximaler Schaden erreicht")
	else:
		Global.ui.set_round_count_label_text("Wo Nico?")

func go_afk_next_round(var afk_healing_bonus):
	self.afk_healing_bonus = afk_healing_bonus
	goes_afk_next_round = true
	Global.ui.set_round_count_label_text("Geht nächste Runde AFK")


func generate_cards_in_deck(var amount: int):
	generate_special_cards_in_deck()


func generate_special_cards_in_deck():
	var viewport:Vector2 = get_viewport().get_visible_rect().size 
	var instance
	for i in range(0,afk_card_amount):
		instance = afk_card.instance()	
		instance.position = Vector2(-100,viewport.y+100)
		instance.init(self)
		put_card_in_deck(instance)
	for i in range(0,nicos_help_card_amount):
		instance = nicos_help_card.instance()	
		instance.position = Vector2(-100,viewport.y+100)
		instance.init(self)
		put_card_in_deck(instance)
	for i in range(0,jaegermeister_card_amount):
		instance = jaegermeister_card.instance()	
		instance.position = Vector2(-100,viewport.y+100)
		instance.init(self)
		put_card_in_deck(instance)
	
	

	


