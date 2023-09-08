extends CanvasLayer

@onready var pause_menu = $Control/PauseMenu

@onready var pause_button = $Control/PauseButton

@onready var music_button = $Control/PauseMenu/VBoxContainer/MusicButton

@onready var sound_button = $Control/PauseMenu/VBoxContainer/SoundButton

var quit_path = "res://scenes/main_menu.tscn"

func _ready():
	pause_menu.visible=false
	update_button_text()

func update_visibility():
	pause_menu.visible=get_tree().paused
	pause_button.visible=!get_tree().paused

func resume():
	get_tree().paused=false

func pause():
	get_tree().paused=true

func update_button_text():
	music_button.text="Music: "+sound_system.get_current_music_status()
	sound_button.text="Sound: "+sound_system.get_current_sound_status()

func _on_pause_button_pressed():
	pause()
	update_visibility()


func _on_resume_button_pressed():
	resume()
	update_visibility()


func _on_restart_button_pressed():
	resume()
	update_visibility()
	scene_changer.reload_scene()


func _on_quit_button_pressed():
	resume()
	update_visibility()
	scene_changer.change_scene(quit_path)


func _on_music_button_pressed():
	sound_system.toggle_music()
	update_button_text()


func _on_sound_button_pressed():
	sound_system.toggle_sound()
	update_button_text()
