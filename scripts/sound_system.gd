extends Node

var music_bus = AudioServer.get_bus_index("Music")

var sound_bus = AudioServer.get_bus_index("Sound")

func toggle_music():
	AudioServer.set_bus_mute(music_bus, !AudioServer.is_bus_mute(music_bus))

func toggle_sound():
	AudioServer.set_bus_mute(sound_bus, !AudioServer.is_bus_mute(sound_bus))

func get_current_music_status():
	if AudioServer.is_bus_mute(music_bus):
		return "off"
	else:
		return "on"

func get_current_sound_status():
	if AudioServer.is_bus_mute(sound_bus):
		return "off"
	else:
		return "on"
