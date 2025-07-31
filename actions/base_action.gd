class_name BaseAction
extends Script

var finished := false
var sub_actions: Array = []

func start(context: Dictionary) -> void:    # initialize state, read context (e.g. target_pos)
	finished = false

func update() -> void:          # drive the behavior each tick
	if sub_actions.is_empty():
		_on_no_subaction()
	else:
		var current = sub_actions[0]
		current.update()
		if current.is_finished():
			sub_actions.pop_front()

func is_finished() -> bool:                 # tell AIActor when to pick the next action
	return finished

func stop() -> void:                        # cleanup if pre-empted
	finished = true

func _on_no_subaction():
	finished = true
