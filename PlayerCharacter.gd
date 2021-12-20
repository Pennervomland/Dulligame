extends Sprite

onready var hp = 100
onready var armor = 0 


onready var hp_bar = $Control/ProgressBar
onready var card_on_char_marker = $card_on_char

var dead = false


# Called when the node enters the scene tree for the first time.
func _ready():
	hp_bar.value = 100
	card_on_char_marker.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(hp_bar.value <= 0 && dead == false):
		rotation = 90
		dead = true


func apply_damage(var damage):
	hp = hp - damage




