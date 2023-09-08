extends CanvasLayer


@onready var container = $Control/VBoxContainer/VBoxContainer

func add_objective(message:String):
	var l = Label.new()
	l.text = message
	container.add_child(l)

func close():
	visible=false
	resume()

func open():
	visible=true
	pause()

func _on_button_pressed():
	close()

func resume():
	get_tree().paused=false

func pause():
	get_tree().paused=true
