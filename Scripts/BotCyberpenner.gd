extends Node2D

onready var game = get_tree().root.get_child(1)
onready var chat_label = $Communication/Chat/ChatLabel
onready var chat_timer = $Communication/ChatTimer
onready var chat = $Communication/Chat
onready var hp_bar = $ProgressBar
onready var attack_timer = $AttackTimer
onready var end_turn_timer = $EndTurnTimer
onready var attack_three_timer = $AttackThreeTimer
onready var bot_ui = Global.ui
onready var attack_three_animation = preload("res://Scenes/AttackThreeAnimation.tscn")

var start_hp
var is_player1
var player_name = "Penner"

export var hp = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	hp_bar.value = self.hp

func begin_turn():
	attack_timer.start()
	bot_ui.get_child(0).visible = false

func put_salt_in_wound():
	chat_timer.start()
	chat.visible = true
	chat_label.text = "Ich kann mich eh nicht heilen\n du kek"

func end_turn():
	chat_timer.start()
	chat.visible = true
	chat_label.text = "Du bist dran"

func start_end_turn_timer():
	end_turn_timer.start()

func roll_attack():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var number = rng.randi_range(1, 3)
	choose_attack(number)

func choose_attack(var attack_number):
	match attack_number:
		1:
			attack_one()
		2:
			attack_two()
		3: 
			attack_three()

func attack_one():
	$AttackAnimation.play("AttackOne")

func attack_two():
	$AttackAnimation.play("AttackTwo")
	chat_timer.start()
	chat.visible = true
	chat_label.text = "Hier gönn dir ein Leben\n     <3"

func apply_enemy_heal(var heal):
	Global.inactive_player.apply_healing(heal)

func attack_three():
	var instance = attack_three_animation.instance()
	add_child(instance)
	instance.position.x = -700
	attack_three_timer.start()

func apply_enemy_damage(var damage):
	Global.inactive_player.apply_damage(damage)

func hide_ui():
	pass

func apply_damage(var damage):
	hp_bar.value -= damage
	if hp_bar.value <= 0:
		rotation_degrees = 180
		attack_three_timer.paused = true
		end_turn_timer.paused = true
		attack_timer.paused = true
		bot_ui.get_child(3).get_child(0).rect_position.x += 100
		bot_ui.get_child(3).get_child(0).text = "Cyberpenner LOST"
		chat.visible = true
		chat.rotation_degrees = 180
		chat.position.x += 400
		chat_label.text = "FUUUUUUUUUUUUUUUUUCK"

func _on_ChatTimer_timeout():
	chat.visible = false
	chat_label.text = ""

func _on_AttackTimer_timeout():
	roll_attack()


func _on_EndTurnTimer_timeout():
	bot_ui.get_child(0).visible = true
	bot_ui._on_EndTurnButton_pressed()
	end_turn_timer.stop()


func _on_AttackThreeTimer_timeout():
	Global.inactive_player.apply_damage(30)
	chat_timer.start()
	chat.visible = true
	chat_label.text = "GET FUCKED N00B"
	start_end_turn_timer()
