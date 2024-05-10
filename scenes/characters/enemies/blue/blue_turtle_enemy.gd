extends AnimatableBody2D

var direction := 1.0

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.flip_h = true
	

func _physics_process(delta: float) -> void:
	
	if ray_cast_left.is_colliding():
		direction = 1.0
		animated_sprite_2d.flip_h = true
	elif ray_cast_right.is_colliding():
		direction = -1.0
		animated_sprite_2d.flip_h = false
	
	position.x += direction * 60.0 * delta
	
	
