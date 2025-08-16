extends BTAction

var owner_id_var: StringName = &"owner_id"

func _tick(_delta: float) -> Status:
	if !blackboard.has_var(&"target_position"):
		return FAILURE
	if !blackboard.has_var(&"position"):
		return FAILURE
	var id = blackboard.get_var(owner_id_var, "")
	var target: Vector3 = blackboard.get_var(&"target_position", Vector3.ZERO)

	EventBus.emit_event("entity_input", id, {"target": target, "input_type": "look_at"})
	
	return SUCCESS
