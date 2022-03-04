extends Sprite

onready var timer = $Timer
onready var animation_spin = $AnimationSpinner
onready var animation_move = $AnimationMover
onready var destroy_timer = $DestroyTimer



# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	destroy_timer.start()
	Global.helper_bots_active +=1
	animation_spin.play("spin")

func _process(delta):
	pass

func _on_Timer_timeout():
	if (Global.helper_bots_active == 1):
		animation_move.play("path1")
	elif (Global.helper_bots_active == 2):
		animation_move.play("path2")
	elif (Global.helper_bots_active == 3):
		animation_move.play("path3")
	elif (Global.helper_bots_active == 4):
		animation_move.play("path4")
	elif (Global.helper_bots_active == 5):
		animation_move.play("path5")
	


func _on_DestroyTimer_timeout():
	Global.helper_bots_active -=1
	queue_free()
