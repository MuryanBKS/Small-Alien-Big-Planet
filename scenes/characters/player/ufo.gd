extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func reset() -> void:
	animation_player.play("Reset")

func land() -> void:
	animation_player.play("land")
	
func hide_light() -> void:
	animation_player.play("hide_light")
	
func show_light() -> void:
	animation_player.play_backwards("hide_light")

func play_move_sound() -> void:
	audio_stream_player.play()

