extends Control

@onready var music_button = $VBoxContainer/MusicButton

@onready var sound_button = $VBoxContainer/SoundButton

var menu_path = "res://scenes/main_menu.tscn"

func _ready():
	update_button_text()

func update_button_text():
	music_button.text="Music: "+sound_system.get_current_music_status()
	sound_button.text="Sound: "+sound_system.get_current_sound_status()

func _on_music_button_pressed():
	sound_system.toggle_music()
	update_button_text()

func _on_sound_button_pressed():
	sound_system.toggle_sound()
	update_button_text()


func _on_back_button_pressed():
	scene_changer.change_scene(menu_path)
