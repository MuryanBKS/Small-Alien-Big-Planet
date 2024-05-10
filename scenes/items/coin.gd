extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	play_floating_animation()
	
	
func _on_body_entered(body: Node2D) -> void:
	get_coin()

func play_floating_animation() -> void:
	var tween := create_tween()
	var position_offset := Vector2(0.0, 2.0)
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(animated_sprite, "position", animated_sprite.position - position_offset, 0.8)
	tween.tween_property(animated_sprite, "position", animated_sprite.position + position_offset, 0.8)
	
	
func get_coin() -> void:
	pickup_sound.play()
	collision_shape.set_deferred("disabled", true)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", position - Vector2(0.0, 30.0), 0.2)
	tween.tween_property(animated_sprite, "scale", Vector2(0.0, 0.0), 0.4)
	tween.finished.connect(queue_free)
	Dialogic.VAR.coin += 1
