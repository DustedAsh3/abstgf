class_name InputComponent
extends BaseComponent

# List of expected actions for MVP:
const MOVE_LEFT = "move_left"
const MOVE_RIGHT = "move_right"
const MOVE_FORWARD = "move_forward"
const MOVE_BACK = "move_back"
const JUMP = "jump"
const DODGE = "dodge"
const ATTACK = "attack"
const MENU = "menu"

var last_vector : Vector2 = Vector2.ZERO

func _unhandled_input(event):
	var move_vector = Vector2(
		Input.get_axis(MOVE_LEFT, MOVE_RIGHT), 
		Input.get_axis(MOVE_FORWARD, MOVE_BACK)
	)
	if move_vector.length() > Options.joystick_deadzone or move_vector != last_vector: 
		EventBus.emit_event("player_input", owner_id, {
			"input_type": "move",
			"direction": move_vector.normalized(),
		})
	if move_vector != last_vector: last_vector = move_vector

	if event.is_action_pressed(JUMP):
		EventBus.emit_event("player_input", owner_id, {
			"input_type": "jump",
		})

	if event.is_action_pressed(DODGE):
		EventBus.emit_event("player_input", owner_id, {
			"input_type": "dodge",
		})

	if event.is_action_pressed(ATTACK):
		EventBus.emit_event("player_input", owner_id, {
			"input_type": "attack",
			"state": "pressed",
		})
	elif event.is_action_released(ATTACK):
		EventBus.emit_event("player_input", owner_id, {
			"input_type": "attack",
			"state": "released",
		})
	
	if event.is_action_pressed(MENU):
		get_tree().quit() #temp
