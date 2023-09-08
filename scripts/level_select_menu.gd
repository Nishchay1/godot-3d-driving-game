extends Control

var car_select_path = "res://scenes/car_select_menu.tscn"

var menu_path = "res://scenes/main_menu.tscn"

var selected_level = 0
var max_level = 19
var unlocked_levels
var original_level_image_paths = ["icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg"]
var level_names = ["Level1","Level2","Level3","Level4","Level5","Level6","Level7","Level8","Level9","Level10","Level11","Level12","Level13","Level14","Level15","Level16","Level17","Level18","Level19","Level20"]
#var level_names = ["Tutorial", "test1","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg","icon.svg", "icon.svg"]
var original_level_descriptions = ["Level1","Level2","Level3","Level4","Level5","Level6","Level7","Level8","Level9","Level10","Level11","Level12","Level13","Level14","Level15","Level16","Level17","Level18","Level19","Level20"]
#var original_level_descriptions = ["Tutorial", "simple ramp jump no deadly aspects on road", "jump over an abyss", "simple track in the air", "slightly steep track with geometric obstacles (small cubes, large cubes, pillars, etc)", "loop de loop over abyss", "crazy long and twisty track with some jumps", "many loop de loops that ends in a jump", "long jump over to giant cubes", "long twisty track but with some deadly/nondeadly obstacles", "just a long cruise with slow down areas and some obstacles but if avoided its satisfyingly smooth and a ramp or hill somewhere for a smooth jump", "spiral track", "tunnel", "tightrope", "something with lots of descents but not with a steep thing its like stairs or platforming almost", "another long twisty track that even goes upside down at one part and has some jumps here and there", "something with lots of obstacles and very high speed", "a large drop", "choose the right ramp level", "super high up steep track"]

var level_image_paths=[]
var level_descriptions=[]

var lock_image_path = "icon.png"

@onready var level_image = $ColorRect/VBoxContainer/HBoxContainer/VBoxContainer/LevelImage
@onready var level_description = $ColorRect/VBoxContainer/HBoxContainer/VBoxContainer2/LevelDescription
@onready var level_name = $ColorRect/VBoxContainer/HBoxContainer/VBoxContainer/LevelName

@onready var start_button = $ColorRect/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer/PlayButton

func _ready():
	unlocked_levels = data_manager.get_levels_unlocked()
	for i in range(0,unlocked_levels):
		level_image_paths.append(original_level_image_paths[i])
		level_descriptions.append(original_level_descriptions[i])
	for i in range(unlocked_levels,max_level+1):
		level_image_paths.append(lock_image_path)
		level_descriptions.append(original_level_descriptions[i]+" Locked. Complete previous level to unlock this one.")
	update_level_info()

func update_level_info():
	if selected_level<unlocked_levels:
		start_button.text="Start"
	else:
		start_button.text="Locked"
	level_name.text = level_names[selected_level]
	level_image.texture = load(level_image_paths[selected_level])
	level_description.text=level_descriptions[selected_level]


func _on_left_button_pressed():
	if selected_level>0:
		selected_level-=1
		update_level_info()


func _on_right_button_pressed():
	if selected_level<max_level:
		selected_level+=1
		update_level_info()


func _on_play_button_pressed():
	if selected_level<unlocked_levels:
		data_manager.set_selected_level(selected_level)
		scene_changer.change_scene(car_select_path)


func _on_back_button_pressed():
	scene_changer.change_scene(menu_path)
