extends Node2D

var direction := 1.0
var activated := false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var timer: Timer = $Timer

func _ready() -> void:
	screen_notifier.screen_entered.connect(_on_screen_entered)
	screen_notifier.screen_exited.connect(_on_screen_exited)
	
	
	animated_sprite_2d.flip_h = true
	var tween := create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", position.y + 20.0, 1.0)
	tween.tween_property(self, "position:y", position.y - 20.0, 1.0)

func _physics_process(delta: float) -> void:
	if activated:
		position.x += direction * 40.0 * delta
	
func _on_screen_entered():
	activated = true
	
func _on_screen_exited():
	timer.start()


func _on_timer_timeout() -> void:
	queue_free()
