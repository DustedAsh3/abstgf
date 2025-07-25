extends Node

enum game_states { MENU, PLAYING, EXTRACT, GAMEOVER, SCORESCREEN}

var state : game_states
var can_extract : bool = true #only false on boss fights
var current_wave : int = 0

func _ready():
	pass

func start_game():
	pass

func end_game():
	pass

func handle_extraction():
	if can_extract:
		pass
	pass

func reset_game():
	pass
