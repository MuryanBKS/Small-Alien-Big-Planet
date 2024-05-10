extends Node2D


@export var min_jump_height := 100.0
@export var max_jump_height := 200.0
@export var min_jump_time := 1.0
@export var max_jump_time := 2.0


func _ready() -> void:
	
	var jump_height := Vector2(0.0, randf_range(min_jump_height, max_jump_height))
	var jump_time := randf_range(min_jump_time, max_jump_time)
	
	var tween := create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", position - jump_height, jump_time)
	tween.tween_property(self, "scale", Vector2(1.3, -1.3), 0.5)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", position + jump_height, jump_time)
	tween.tween_property(self, "scale", Vector2(1.3, 1.3), 0.5)

