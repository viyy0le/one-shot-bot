extends Button
var player_name : String
var player_phone : String
var dragable := false
var is_dragging := false
var on_table : VBoxContainer



func _ready() -> void:
	CsvToFile.on_table.connect(reparent_to_table)

func reparent_to_table(table:VBoxContainer):
	on_table = table


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left-click"):
		if dragable:
			is_dragging = true
	if Input.is_action_pressed("left-click"):
		if is_dragging:
			global_position = get_global_mouse_position()
	if Input.is_action_just_released("left-click"):
		if is_dragging and on_table !=null:
			reparent(on_table.player_cont)
			is_dragging = false
			dragable = false


func add_name_phone(n:String , p: String):
	player_name = n
	player_phone = p
	text = player_name

func _on_pressed() -> void:
	DisplayServer.clipboard_set(player_name + " " + player_phone)


func _on_mouse_entered() -> void:
	dragable = true
	text = player_phone


func _on_mouse_exited() -> void:
	dragable = false
	text = player_name
