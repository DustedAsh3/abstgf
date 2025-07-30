extends LineEdit

@onready var player: CharacterBody3D = $"../.."

func _ready() -> void:
	hide()
	process_mode = PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event.is_action_released("open_console"):
		show()
		grab_focus()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
	if event.is_action_released("menu"):
		release_focus()
		hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		get_tree().paused = false
	if event.is_action_released("execute_command"):
		process_command()
		release_focus()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		hide()
		get_tree().paused = false

func process_command():
	var input_text := text.strip_edges()
	if input_text == "":
		return
	
	var tokens := input_text.split(" ")
	var command := tokens[0]
	var args := tokens.slice(1, tokens.size())
	
	match command:
		"spawn":
			pass
			#handle_spawn_command(args)
		"event":
			handle_event_command(args)
		"teleport":
			pass
			#handle_teleport_command(args)
		"echo":
			Debug.Log("Console: ".join(args))
		"get_player_id":
			Debug.Log("Player ID: " + str(player.get_instance_id()))
		"display_state":
			Debug.Log(str(EventBus.stateful_data))
		_:
			Debug.Log("Unknown command: " + command)

func handle_event_command(args: Array) -> void:
	if args.size() == 0:
		Debug.Log("Usage: event <event_name> <target_id>, <{data}>")
		return
	EventBus.emit_event(args[0], int(args[1]), JSON.parse_string(args[2]))
