extends VBoxContainer
@export var gm_name_lbl: Label
@export var game_name_lbl: Label
@export var player_scn : PackedScene
@export var player_cont : GridContainer
@export var collision_s : CollisionShape2D
var game_name_org:String
func set_labels(gm_name:String , game_name:String):
	game_name_org = game_name
	gm_name_lbl.text = gm_name
	game_name_lbl.text = game_name

func add_player(player_name : String , player_phone: String):
	player_cont.get_parent().show()
	var player_instance = player_scn.instantiate()
	player_instance.add_name_phone(player_name , player_phone)
	player_cont.add_child(player_instance)
	collision_s.check_size()


func remove_players():
	for child in player_cont.get_children():
		child.queue_free()


func _on_area_2d_mouse_entered() -> void:
	CsvToFile.on_table.emit(self)

func _on_area_2d_mouse_exited() -> void:
	CsvToFile.on_table.emit(null)
