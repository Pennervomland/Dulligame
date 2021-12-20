extends Sprite


export var damage = 10
export var mana_costs = 1
export var healing = 5
export var armor = 3
export var mana_regeneration = 1

var is_mouse_on_card: bool
var is_card_in_use: bool
var is_card_in_focus: bool

var mouse_pos = get_global_mouse_position()

onready var start_pos = position

# Called when the node enters the scene tree for the first time.
func _ready():
	is_mouse_on_card = false
	is_card_in_use = false
	is_card_in_focus = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Has to be in game script later and improve!
	if(Input.is_action_just_pressed("LeftMB")== true && is_mouse_on_card==true):
		is_card_in_use = true
		is_card_in_focus = false
	if(Input.is_action_just_pressed("RightMB") == true && is_card_in_use == true):
		is_card_in_use = false
		scale = Vector2(0.5,0.5)
		position = start_pos
	if(is_card_in_use == true):
		scale = Vector2(1,1)
		position = Vector2(512,220)

func trigger_effect():
	pass


func _on_Area2D_mouse_entered():
	is_mouse_on_card = true
	if(is_card_in_use == false):
		scale.x = 0.75
		scale.y = 0.75
		is_card_in_focus = true

func _on_Area2D_mouse_exited():
	if(is_card_in_use == false):
		scale.x = 0.5
		scale.y = 0.5
	is_mouse_on_card = false
	is_card_in_focus = false
