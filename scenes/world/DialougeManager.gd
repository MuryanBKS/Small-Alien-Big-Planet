extends Node

var player: Player


func start_first_dialouge() -> void:
	player = get_tree().get_first_node_in_group("player")
	var layout = Dialogic.start("game_start")
	layout.register_character(load("res://dialogic_resource/player.dch"), player)

func delete_dialouge_lag():
	player = get_tree().get_first_node_in_group("player")
	var layout = Dialogic.start("touch_enemy_died")
	layout.register_character(load("res://dialogic_resource/player.dch"), player)
	await get_tree().create_timer(0.2).timeout
	Dialogic.end_timeline()
	player.is_in_dialouge = true
