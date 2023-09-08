extends Control

var level_select_path = "res://scenes/level_select_menu.tscn"
var options_path = "res://scenes/options_menu.tscn"

func _on_play_button_pressed():
	scene_changer.change_scene(level_select_path)


func _on_options_button_pressed():
	scene_changer.change_scene(options_path)
