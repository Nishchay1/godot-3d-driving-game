extends Control

var selected_car
var cars_list
var max_car_number
var cars_unlocked_list
var car_image_paths = ["icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg"]

var level

var level_select_path = "res://scenes/level_select_menu.tscn"

@onready var car_image = $ColorRect/VBoxContainer/HBoxContainer/VBoxContainer/CarImage
@onready var car_name = $ColorRect/VBoxContainer/HBoxContainer/VBoxContainer/CarName

@onready var select_button = $ColorRect/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/SelectButton

func _ready():
	cars_list = data_manager.get_cars_list()
	cars_unlocked_list = data_manager.get_cars_unlocked()
	max_car_number=cars_list.size()-1
	selected_car = data_manager.get_current_selected_car()
	level = data_manager.get_selected_level()
	update_car_info()

func update_car_info():
	if cars_unlocked_list[selected_car]==0:
		select_button.text = "Locked"
	else:
		select_button.text = "Play"
	car_name.text = cars_list[selected_car]
	car_image.texture = load(car_image_paths[selected_car])


func _on_left_button_pressed():
	if selected_car>0:
		selected_car-=1
		update_car_info()


func _on_right_button_pressed():
	if selected_car<max_car_number:
		selected_car+=1
		update_car_info()


func _on_select_button_pressed():
	if cars_unlocked_list[selected_car]==1:
		data_manager.set_current_selected_car(selected_car)
		scene_changer.change_scene("res://scenes/levels/level"+str(level)+"+.tscn")


func _on_back_button_pressed():
	scene_changer.change_scene(level_select_path)
