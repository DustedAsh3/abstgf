extends Node

signal event_emitted(event_name, target_id, data)  # data is a Dictionary of any type you want

func emit_event(event_name: String, target_id: int, data: Dictionary = {}):
	emit_signal("event_emitted", event_name, target_id, data)
	print("event emitted: " + event_name + ", " + str(target_id) + ", " + str(data))
