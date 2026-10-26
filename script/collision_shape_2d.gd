extends CollisionShape2D

func _process(_delta: float) -> void:
	check_size()


func check_size():
	var grandparent = get_parent().get_parent()
	shape.size = grandparent.size
	global_position = grandparent.global_position + grandparent.size * grandparent.pivot_offset_ratio
