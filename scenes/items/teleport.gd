extends Area2D

@export var next_teleport: Node2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		audio_stream_player_2d.play()
		var tween := create_tween()
		tween.tween_property(body, "scale", Vector2(0.0, 0.0), 0.4)
		await tween.finished
		tween = create_tween()
		body.global_position = next_teleport.global_position
		tween.tween_property(body, "scale", Vector2(1.0, 1.0), 0.4)
		audio_stream_player_2d.play()
		await tween.finished
		
		next_teleport.queue_free()
		queue_free()
