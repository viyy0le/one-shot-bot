extends Node
var player_file = {}
var games_file = {}
var games_list := {}
var orphan_players := []

signal on_table(table: VBoxContainer)


func configure_things():
	list_games()
	place_players()
	for game in games_list:
		print(game)
		print( "GM: " + str(games_file[game]["İlk olarak seninle başlayalım. İsmini ve soy ismini öğrenebilir miyiz?

Let us start with you first. Can we get your name and surname?"] + "\n"))
		print("Players: ")
		for player in games_list[game]["players"]:
			print(player , " " , player_file[player]["Telefon Numaran? / Your phone number?"])
		print("\n")
	print(orphan_players)

func csv_to_file(path:String , no: int) -> Dictionary:
	var categories_found := false
	var categories := []
	var all_members := {}
	var file = FileAccess.open(path , FileAccess.READ)
	while not file.eof_reached():
		while not categories_found:
			var main_line = file.get_csv_line()
			categories = main_line
			categories_found = true
		var line = file.get_csv_line()
		#print(line_no)
		all_members[line[no]] = line
	#print(categories[0])
	#print(all_members)
	var new_members = {}
	for i in range(categories.size() -1):
		for member in all_members:
			if not new_members.has(member):
				new_members[member] = {}
			#print(all_members[member][i])
			new_members[member][categories[i]] = all_members[member][i]
	all_members = new_members
	return all_members

func place_players():
	orphan_players = []
	for player in player_file:
		var player_choices := []
		player_choices.append(player_file[player]["Yukarıdaki masalar arasından hangisi ilk tercihin? / Which of the games above would be your first choice?"])
		player_choices.append(player_file[player]["Yukarıdaki masalar arasından hangisi ikinci tercihin? / Which of the games above would be your second choice?"])
		player_choices.append(player_file[player]["Yukarıdaki masalar arasından hangisi üçüncü tercihin? / Which of the games above would be your third choice?"])
		if games_list[player_choices[0]]["curr"] < games_list[player_choices[0]]["max"]:
			games_list[player_choices[0]]["players"].append(player)
			games_list[player_choices[0]]["curr"] += 1
		elif games_list[player_choices[1]]["curr"] < games_list[player_choices[1]]["max"]:
			games_list[player_choices[1]]["players"].append(player)
			games_list[player_choices[1]]["curr"] += 1
		elif games_list[player_choices[2]]["curr"] < games_list[player_choices[2]]["max"]:
			games_list[player_choices[2]]["players"].append(player)
			games_list[player_choices[2]]["curr"] += 1
		else:
			orphan_players.append(player)
		#print(games_list)

func list_games():
	for game in games_file:
		games_list[game] = {"max" : 0 , "curr" : 0 , "players" : []}
		games_list[game]["max"] = int(games_file[game]["Oyununda kaç oyuncu bulundurabilirsin?\n\nWhat is the number of players you can play with? "])
