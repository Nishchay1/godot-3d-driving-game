extends Node

var save_path = "user://savegame.save"

var cars_list = ["suv","car2","car3","car4","car5","car6"]

var car_paths = ["res://scenes/vehicles/suv.tscn","res://scenes/vehicles/suv.tscn","res://scenes/vehicles/suv.tscn","res://scenes/vehicles/suv.tscn","res://scenes/vehicles/suv.tscn","res://scenes/vehicles/suv.tscn"]

var data = {}

var selected_level = 1

func _ready():
	save_default_data_to_file()
	load_data_from_file()

func get_cars_list():
	return cars_list

func get_current_selected_car():
	return data["current_selected_car_index"]

func get_cars_unlocked():
	return data["cars_unlocked"]

func get_levels_unlocked():
	return data["levels_unlocked"]

func get_gems():
	return data["gems"]

func get_selected_level():
	return selected_level

func get_car_paths():
	return car_paths

func set_current_selected_car(value):
	data["current_selected_car_index"]=value

func set_cars_unlocked(value):
	data["cars_unlocked"]=value

func set_levels_unlocked(value):
	data["levels_unlocked"]=value

func set_gems(value):
	data["gems"]=value

func set_selected_level(value):
	selected_level=value

func load_data_from_file():
	if FileAccess.file_exists(save_path):
		var json = JSON.new()
		var save_game = FileAccess.open(save_path, FileAccess.READ)
		var json_string = save_game.get_line()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		data = json.get_data()
	else:
		save_default_data_to_file()
		load_data_from_file()

func save_data_to_file():
	var save_game = FileAccess.open(save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(data)
	save_game.store_line(json_string)

func save_default_data_to_file():
	data = {
		"cars_unlocked" : [1,0,0,0,0,0],
		"current_selected_car_index" : 0,
		"levels_unlocked" : 1,
		"gems" : 100,
	}
	save_data_to_file()
