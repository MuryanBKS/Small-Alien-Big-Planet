extends Node2D

@export var fall_depth := 108.0

var frame: int = 0
var origin_position = position
var is_falling := false

@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D



func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	
	
func _on_timer_timeout() -> void:
	frame += 1
	animated_sprite_2d.frame = frame % 2
	is_falling = not is_falling
	
	var tween := create_tween()
	if is_falling:
		timer.wait_time = 1.0
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_ease(Tween.EASE_IN)
		tween.tween_property(self, "position", position + Vector2(0.0, fall_depth), 0.5)
		await tween.finished
		audio_stream_player_2d.play()
	else:
		timer.wait_time = randf_range(0.6, 1.5)
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position", position - Vector2(0.0, fall_depth), 1.5)
		await tween.finished
	timer.start()
