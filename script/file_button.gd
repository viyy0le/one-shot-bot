extends Button
@export var file_dialog : FileDialog
@export_enum("GM" , "Player") var gm_or_player 
var file_arrived := false
@export var table:PackedScene
@export var table_cont : GridContainer
signal file

func _ready() -> void:
	pressed.connect(on_pressed)
	file_dialog.file_selected.connect(on_file_selected)

func on_pressed():
	file_dialog.popup()

func on_file_selected(path: String):
	match gm_or_player:
		0:
			for child in table_cont.get_children():
				child.queue_free()
			CsvToFile.games_file = CsvToFile.csv_to_file(path , 7)
			CsvToFile.list_games()
			for game in CsvToFile.games_list:
				var table_instance = table.instantiate()
				var gm_name = str(CsvToFile.games_file[game]["İlk olarak seninle başlayalım. İsmini ve soy ismini öğrenebilir miyiz?

Let us start with you first. Can we get your name and surname?"])
				table_instance.name = game
				table_instance.set_labels(gm_name , game)
				table_cont.add_child(table_instance)
				table_instance.game_name_lbl.check_length()
		1:
			CsvToFile.player_file = CsvToFile.csv_to_file(path , 2)
	text = path.split("/")[-1]
	icon = load("res://icons/icons8-file-20.png")
	file_arrived = true
	file.emit()
