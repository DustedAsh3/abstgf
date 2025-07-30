extends Node

signal event_emitted(event_name, target_id, data)  ## data is a Dictionary of any type you want

var stateful_data := {} ## Data to be held that is not one-shot, but can persist for a few moments

func emit_event(event_name: String, target_id: int, data: Dictionary = {}):
	emit_signal("event_emitted", event_name, target_id, data)
	Debug.Log("event emitted: " + event_name + ", " + str(target_id) + ", " + str(data))

func register_sensor(owner_id, sensor_key, sensor_id):
	if not stateful_data.has(owner_id):
		stateful_data[owner_id] = {}
	if not stateful_data[owner_id].has(sensor_key):
		stateful_data[owner_id][sensor_key] = []
