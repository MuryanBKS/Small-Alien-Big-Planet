extends Area2D

@export var is_enemy := true
@export var can_kill := true

@onready var timer: Timer = $Timer
@onready var reset_timer: Timer = $ResetTimer

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	timer.timeout.connect(_on_timer_timeout)
	reset_timer.timeout.connect(_on_reset_timer_timeout)
	GameManager.player.died.connect(_on_player_died)
	
func _on_body_entered(body: Node2D) -> void:
	if can_kill:
		body.die()
		timer.start()
		reset_timer.start()
	else :
		can_kill = true
	
func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	if Dialogic.current_timeline != null:
		Dialogic.end_timeline()
	GameManager.respawn_player()

func _on_reset_timer_timeout() -> void:
	can_kill = true

func _on_player_died() -> void:
	can_kill = false
	if is_enemy:
		can_kill = true
	
