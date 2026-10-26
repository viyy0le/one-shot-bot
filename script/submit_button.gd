extends Button
@export var gm_button : Button
@export var player_button : Button
@export var table_cont : GridContainer

func _ready() -> void:
	gm_button.file.connect(check_files)
	player_button.file.connect(check_files) 

func _on_pressed() -> void:
	CsvToFile.configure_things()
	for child in table_cont.get_children():
		child.remove_players()
	for game in CsvToFile.games_list:
		for player in CsvToFile.games_list[game]["players"]:
			for child in table_cont.get_children():
				if child.game_name_org == game:
					child.add_player(player, CsvToFile.player_file[player]["Telefon Numaran? / Your phone number?"])
				else:
					pass

func check_files():
	if gm_button.file_arrived and player_button.file_arrived:
		self.disabled = false
