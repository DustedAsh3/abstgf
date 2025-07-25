class_name SaveableComponent
extends BaseComponent

var event_save_complete := "save_complete"
var event_load_complete := "load_complete"

func handle_event(event_name, target_id, event_data):
	super(event_name, target_id, event_data)
	if event_name == "save_game":
		request_save()
	elif event_name == "save_entity" and target_id == owner_id:
		save_component()
	
	if event_name == "load_game":
		load_entity()
	elif event_name == "load_entity" and target_id == owner_id:
		load_entity()
	
	if event_name == "data_emitted" and target_id == owner_id:
		collect_data(event_data)

func collect_data(event_data):
	if !data.has("component_types_list"):
		data["component_types_list"] = []
	if !data["component_types_list"].has(event_data["component_type"]):
		data["component_types_list"].append(event_data["component_type"])
	if event_data["component_type"] != data["component_type"]: 
		data.merge(event_data)

func request_save():
	EventBus.emit_event("emit_data", owner_id, data)
	await(get_tree().create_timer(1).timeout)
	EventBus.emit_event("save_entity", owner_id, data)

func save_component():
	var player_data = PlayerData.new()
	player_data.data = data.duplicate(true)
	ResourceSaver.save(player_data, "res://resources/player_data.tres")
	EventBus.emit_event("entity_saved", owner_id, data)

func load_entity():
	var player_data = ResourceLoader.load("res://resources/player_data.tres","",ResourceLoader.CACHE_MODE_REPLACE)
	data = player_data.data.duplicate(true)
	EventBus.emit_event("set_to_data", owner_id, data)
