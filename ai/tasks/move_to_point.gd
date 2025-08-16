extends BTAction

@export var acceptable_distance: float = 3.0
var owner_id_var: StringName = &"owner_id"

func _tick(_delta: float) -> Status:
	if !blackboard.has_var(&"target_position"):
		return FAILURE
	if !blackboard.has_var(&"position"):
		return FAILURE
	var id = blackboard.get_var(owner_id_var, "")
	var target: Vector3 = blackboard.get_var(&"target_position", Vector3.ZERO)
	var position: Vector3 = blackboard.get_var(&"position")
	var direction: Vector2
	direction.x = target.x - position.x
	direction.y = target.z - position.z
	
	if abs(target - position).length() < acceptable_distance:
		return SUCCESS
	direction = direction.normalized()
	EventBus.emit_event("entity_input", id, {"direction": direction, "input_type": "move"})
	
	return RUNNING
