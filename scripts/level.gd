extends Node3D

@onready var spawnpoint = $SpawnPoint

var car_paths

var car_scene

var selected_car_index

@export var is_timed:bool

@export var time_limit:float

@export var has_speed_requirement:bool

@export var speed_requirement:float

@onready var finish_area = $FinishArea

@onready var pop_up_message = $PopUpMessage

@onready var objectives_display = $ObjectivesDisplay

var speed_objective_met:bool = false
var time_objective_met:bool = false

func _ready():
	car_paths = data_manager.get_car_paths()
	selected_car_index = data_manager.get_current_selected_car()
	spawn_car()
	if has_requirements():
		if has_speed_requirement:
			objectives_display.add_objective("Reach the finish going at "+str(speed_requirement)+"mph.")
		if is_timed:
			objectives_display.add_objective("Reach the finish in "+str(time_limit)+" seconds.")
		objectives_display.open()
	else:
		objectives_display.close()

func spawn_car():
	car_scene = load(car_paths[selected_car_index])
	var instance = car_scene.instantiate()
	instance.transform = spawnpoint.transform
	add_child(instance)

func check_objectives(speed):
	if speed>=speed_requirement or has_speed_requirement==false:
		speed_objective_met=true
	else:
		speed_objective_met=false
	if get_time_remaining()>=time_limit or is_timed==false:
		time_objective_met=true
	else:
		time_objective_met=false
	return speed_objective_met and time_objective_met

func _on_finish_area_finished(value):
	if has_requirements():
		if check_objectives(value):
			level_complete()
		else:
			display_message("One or more objectives not met.")
	else:
		level_complete()

func level_complete():
	print("level complete")

func display_message(message):
	pop_up_message.pop_up(message)

func has_requirements():
	return has_speed_requirement or is_timed

func get_time_remaining():
	return 0
