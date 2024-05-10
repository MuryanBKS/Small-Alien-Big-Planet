extends StaticBody2D

var diamond_scene := preload("res://scenes/items/diamond.tscn")

@onready var chest_area: Area2D = $ChestArea
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	chest_area.body_entered.connect(_on_body_entered)
	
	#var tween := create_tween()
	#tween.set_loops()
	#tween.set_trans(Tween.TRANS_SINE)
	#tween.set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(self, "position", position - Vector2(0.0, 5.0), 1.0)
	#tween.tween_property(self, "position", position + Vector2(0.0, 5.0), 1.0)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		chest_area.set_deferred("monitoring", false)
		audio_stream_player_2d.play()
		
		if not Dialogic.VAR.get_key:
			audio_stream_player_2d.play()
			chest_area.set_deferred("monitoring", true)
			return
		await audio_stream_player_2d.finished
		queue_free()
