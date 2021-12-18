extends Sprite

onready var hp = 100
onready var hp_bar = $ProgressBar
onready var card_on_char = $card_on_char
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dead = false


# Called when the node enters the scene tree for the first time.
func _ready():
	hp_bar.value = 100
	card_on_char.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(hp_bar.value <= 0 && dead == false):
		rotation = 90
		dead = true
		print("asd")

func _on_Area2D_area_entered(area):
	card_on_char.visible = true

	


func _on_Area2D_area_exited(area):
	card_on_char.visible = false


func _on_CardMax_mouse_released():
	if(card_on_char.visible == true):
		hp_bar.value -= 10
