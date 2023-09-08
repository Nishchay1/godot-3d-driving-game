extends Area3D

signal finished

var level_select_path = "res://scenes/level_select_menu.tscn"

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("finished", body.get_speed())
