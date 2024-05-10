extends CharacterBody2D
class_name Player

signal died

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_died := false
var is_in_dialouge := true

@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var died_sound: AudioStreamPlayer = $DiedSound
@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var coyote_timer: Timer = $CoyoteTimer



func _ready() -> void:
	Dialogic.timeline_started.connect(start_dialogue)
	Dialogic.timeline_ended.connect(end_dialouge)
	GameManager.respawned.connect(_on_respawned)
	
	
func _process(delta: float) -> void:
	if is_died:
		sprite.play("run")
		return
	elif is_in_dialouge:
		sprite.play("idle")
		return
	animate()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_died or is_in_dialouge:
		velocity.x = 0.0
		move_and_slide()
		return
		
		
		
	# Handle jump.
	var was_on_floor := is_on_floor()

	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_timer.time_left > 0.0):
		jump_sound.pitch_scale = randf_range(1.0, 1.3)
		jump_sound.play()
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
	move_and_slide()
	
	var just_left_ledge: bool = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_timer.start()
		
		
func animate():
	var direction := Input.get_axis("move_left", "move_right")
		
	if direction:
		sprite.play("run")
	else:
		sprite.play("idle")
		
	if not is_on_floor():
		sprite.play("jump")
		
	if direction > 0:
		sprite.flip_h = true
	elif direction < 0:
		sprite.flip_h = false

func die() -> void:
	died.emit()
	died_sound.play()
	is_died = true
	
	Engine.time_scale = 0.7
	collision_shape_2d.set_deferred("disabled", true)
	
	
func start_dialogue() -> void:
	is_in_dialouge = true

func end_dialouge() -> void:
	is_in_dialouge = false

func _on_respawned() -> void:
	collision_shape_2d.set_deferred("disabled", false)
	
func reset() -> void:
	is_died = false
