extends Sprite

signal mouse_released


export var damage = 10
export var mana_costs = 1
export var healing = 5
export var armor = 3
export var mana_regeneration = 1

var is_mouse_on_card

var mouse_pos = get_global_mouse_position()

onready var start_pos = position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Has to be in game script later and improve!
	if(Input.is_mouse_button_pressed(1) == false):
		position = start_pos
		emit_signal("mouse_released")
	if(is_mouse_on_card && Input.is_mouse_button_pressed(1)):
		position.x = get_global_mouse_position().x
		position.y = get_global_mouse_position().y


func trigger_effect():
	pass


func _on_Area2D_mouse_entered():
	scale.x += 0.25
	scale.y += 0.25
	is_mouse_on_card = true


func _on_Area2D_mouse_exited():
	scale.x -= 0.25
	scale.y -= 0.25
	is_mouse_on_card = false
