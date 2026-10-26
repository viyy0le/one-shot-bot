extends Label
@export var collision_s : CollisionShape2D


func _ready() -> void:
	check_length()


func check_length():
	if text.length() > 25:
		text = text.replace(text.substr(25) , "")
		text += "..."
	collision_s.check_size()
	
