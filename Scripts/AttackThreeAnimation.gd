extends Node2D

onready var helper_cyberpenner = preload("res://Scenes/HelperCyberpenner.tscn")
onready var timer = $Timer
onready var destroy_timer = $DestroyTimer
onready var pos1 = $Position1
onready var pos2 = $Position2
onready var pos3 = $Position3
onready var pos4 = $Position4
onready var pos5 = $Position5

var counter:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Timer_timeout():
	var instance = helper_cyberpenner.instance()
	add_child(instance)
	counter += 1
	match counter:
		1:
			instance.position = pos1.position
		2:
			instance.position = pos2.position
		3:
			instance.position = pos3.position
		4:
			instance.position = pos4.position
		5:
			instance.position = pos5.position
			timer.stop()


func _on_DestroyTimer_timeout():
	queue_free()
