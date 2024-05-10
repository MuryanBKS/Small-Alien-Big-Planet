extends Area2D
class_name CheckPoint

@export var is_final_flag := false 

var activated := false

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	
func  activate() -> void:
	GameManager.current_checkpoint = self
	activated = true
	animation_player.play("activate")
	
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player and not activated:
		activate()
	if is_final_flag:
		is_final_flag = false
		GameManager.animation_player.play("call_ufo")
