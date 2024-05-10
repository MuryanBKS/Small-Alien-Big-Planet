extends Camera2D

var player: CharacterBody2D

func _ready() -> void:
	player = GameManager.player
	
func _process(delta: float) -> void:
	if player == null:
		return
	global_position = lerp(global_position, player.global_position, 1 - exp(-5 * delta))
