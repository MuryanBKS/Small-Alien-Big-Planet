extends Node

signal respawned


var player_scene: PackedScene = preload("res://scenes/characters/player/player.tscn")
var current_checkpoint: CheckPoint
var player: Player
var animation_player: AnimationPlayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		respawn_player()


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	animation_player = get_tree().get_first_node_in_group("animation_player")
	
	
func respawn_player() -> void:
	if current_checkpoint != null:
		player.reset()
		player.position = current_checkpoint.position + Vector2(0.0, -50.0)
		respawned.emit()
		player.velocity.y = 0.0
	else :
		player.reset()
		player.position = Vector2(-184, -36) + Vector2(0.0, -50.0)
		respawned.emit()
		player.velocity.y = 0.0
