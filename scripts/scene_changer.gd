extends CanvasLayer

signal done

@onready var animation_player = $AnimationPlayer

func change_scene(path):
	animation_player.play("fade")
	await animation_player.animation_finished
	assert(get_tree().change_scene_to_file(path) == OK)
	animation_player.play_backwards("fade")
	await animation_player.animation_finished

func reload_scene():
	animation_player.play("fade")
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	animation_player.play_backwards("fade")
	await animation_player.animation_finished

