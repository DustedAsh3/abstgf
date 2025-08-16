extends BTAction


func _tick(_delta: float) -> Status:
	blackboard.set_var(&"target_position", Vector3.ZERO)
	return SUCCESS
