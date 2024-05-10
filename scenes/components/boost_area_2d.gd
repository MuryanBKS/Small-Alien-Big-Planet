extends Area2D

@export var jump_force: float
@export var sfx: AudioStream

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	audio_stream_player_2d.stream = sfx
	
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		audio_stream_player_2d.play()
		body.velocity.y -= jump_force
	
