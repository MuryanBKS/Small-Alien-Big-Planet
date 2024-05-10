extends Area2D

@export var face_left := true

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.flip_h = not face_left
