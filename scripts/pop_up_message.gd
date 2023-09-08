extends Label

func _ready():
	reset()

func pop_up(message:String):
	text = message
	$AnimationPlayer.play("pop_up")

func reset():
	text = ""
	$AnimationPlayer.play("RESET")
