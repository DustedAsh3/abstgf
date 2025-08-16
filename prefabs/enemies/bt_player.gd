extends BTPlayer

var owner_id: String
var owner_entity: Actor

func _ready() -> void:
	owner_entity = get_parent()
	owner_id = owner_entity.id
	blackboard.bind_var_to_property(&"owner_id", owner_entity, "id", true)

func setup_connections():
	var connected = EventBus.connect("event_emitted", handle_event)
	Debug.Log("Connected " + get_class() + " on " + owner_id + ": " + str(connected))

func handle_event(event_name, target_id, event_data):
	if event_name == "debug_blackboard" && target_id == owner_id:
		Debug.Log(owner_id + " blackboard: " + str(blackboard.get_vars_as_dict()))
