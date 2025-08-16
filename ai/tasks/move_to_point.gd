extends BTAction

@export var acceptable_distance: float = 3.0
var owner_id: String 

func _ready():
	owner_id = blackboard.get_var(&"owner_id")

func _tick(_delta: float) -> Status:
	var target: Vector3 = blackboard.get_var(&"target_position", Vector3.ZERO)
	var position: Vector3 = blackboard.get_var(&"position")
	var movement_component: MovementComponent = blackboard.get_var(&"movement_component")
	var direction: Vector2
	direction.x = target.x - position.x
	direction.y = target.z - position.z
	
	if abs(target - position).length() < acceptable_distance:
		return SUCCESS
	
	EventBus.emit_event("move", owner_id, {"direction": direction})
	
	return RUNNING
