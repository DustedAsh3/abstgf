## Base Component
## The Base Component serves as a foundational component, handling it's 
## Creation, Deletion, and Connection to both the EventBus and other Components.

class_name BaseComponent
extends Node

var owner_entity: Node = null  # Reference to parent/entity
var owner_id: int = -2 #-2 means unassigned

var data: Dictionary = {}

func _ready():
	owner_entity = get_parent()
	owner_id = owner_entity.get_instance_id()
	update_data()
	EventBus.emit_event("component_created", owner_id, data)
	call_deferred("handshake")

func handshake(): #Set any component behaviors based on other components
	EventBus.emit_event("component_handshake_complete", owner_id, data)
	call_deferred("initialize")

func initialize(params = {}): #Initialize component with current setup
	# Optional: Set up with params
	update_data()
	setup_connections()
	EventBus.emit_event("component_initialized", owner_id, data)

func cleanup():
	# Optional: Clean up before removal
	EventBus.emit_event("component_destroyed", owner_id, data)
	terminate_connections()
	self.queue_free()

func get_owner_entity():
	return owner_entity

func get_owner_class():
	return owner_entity.get_class()

func update_data(): #extend in child with child data
	data["owner_id"] = owner_id
	data["component_id"] = self.get_instance_id()
	data["component_type"] = self.name

func set_to_data(data_in):
	for key in data:
		if data_in.has(key):
			if key != "owner_id" and key != "component_id" and key != "component_type": #TODO: Clean this up
				var old = data[key]
				if data[key] != data_in[key]:
					data[key] = data_in[key]
					Debug.Log("Updated key '%s': %s -> %s" % [key, str(old), str(data[key])])

func emit_data():
	update_data()
	EventBus.emit_event("data_emitted", owner_id, data)

func accept_data(data_in):
	set_to_data(data_in)
	EventBus.emit_event("data_accepted", owner_id, data)

func setup_connections():
	var connected = EventBus.connect("event_emitted", handle_event)
	Debug.Log("Connected " + get_class() + " on " + str(owner_id) + ": " + str(connected))

func terminate_connections():
	EventBus.disconnect("event_emitted", handle_event)

func handle_event(event_name, target_id, event_data):
	if event_name == "emit_data" and target_id == owner_id:
		emit_data()
	if event_name == "set_to_data" and target_id == owner_id:
		set_to_data(event_data)

func modify_event(target: BaseComponent, property_name: String, new_value):
	var old_value = target.get(property_name)
	Debug.Log("%s %s: event changed from %s to %s" % [
		target.name, target.get_instance_id(), str(old_value), str(new_value)
	])
	target.set(property_name, new_value)
