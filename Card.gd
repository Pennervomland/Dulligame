extends Sprite


export var damage = 10
export var mana_costs = 1
export var healing = 5
export var armor = 3
export var mana_regeneration = 1

var is_mouse_on_card: bool
var is_card_in_use: bool

var mouse_pos = get_global_mouse_position()

onready var start_pos = position

# Called when the node enters the scene tree for the first time.
func _ready():
	is_mouse_on_card = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Has to be in game script later and improve!
	if(Input.is_action_just_pressed("LeftMB")== true):
		print(get_viewport_rect())
	if(Input.is_action_just_released("LeftMB") == true):
		position = start_pos

func trigger_effect():
	pass


func _on_Area2D_mouse_entered():
	is_mouse_on_card = true
	scale.x = 0.75
	scale.y = 0.75

func _on_Area2D_mouse_exited():
	scale.x = 0.5
	scale.y = 0.5
	is_mouse_on_card = false
