extends BTPlayer

var owner_id: String

func _ready():
	owner_id = get_parent().id
	blackboard.set_var(&"owner_id", owner_id)

func setup_connections():
	var connected = EventBus.connect("event_emitted", handle_event)
	Debug.Log("Connected " + get_class() + " on " + owner_id + ": " + str(connected))

func handle_event(event_name, target_id, event_data):
	if event_name == "debug_blackboard" && target_id == owner_id:
		Debug.Log(owner_id + " blackboard: " + str(blackboard.get_vars_as_dict()))
