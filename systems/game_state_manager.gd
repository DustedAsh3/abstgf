extends Node

enum game_states { MENU, PLAYING, EXTRACT, GAMEOVER, SCORESCREEN}

var state : game_states
var current_wave : int = 0
var actor_counts : Dictionary
var actors : Array

func _ready():
	pass

func start_game():
	pass

func end_game():
	pass

func reset_game():
	pass

func request_id(prefix: String) -> String:
	if actor_counts.get(prefix) == null:
		actor_counts[prefix] = 0
	actor_counts[prefix] += 1
	return prefix + "-" + str(actor_counts[prefix])


func register_actor(actor_id):
	actors.append(actor_id)

func deregister_actor(actor_id):
	actors.erase(actor_id)
