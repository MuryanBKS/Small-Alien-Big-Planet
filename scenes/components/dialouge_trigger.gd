extends Area2D

@export var dialouge: String
@export var characters: Array[Node2D]

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if Dialogic.current_timeline != null:
		return
	characters.append(body)
	var layout = Dialogic.start(dialouge)
	for character in characters.size():
		layout.register_character(load("res://dialogic_resource/" + characters[character].name.to_lower() + ".dch"), characters[character])
	queue_free()
	
