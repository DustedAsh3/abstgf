extends Node

var data := {}

var on_save_complete := "save_complete"
var on_load_complete := "load_complete"
var event_save_game := "save_game"
var event_load_game := "load_game"
var event_save_entity := "save_entity"
var event_load_entity := "load_entity"
var print_data := "print_data"

func save_game():
	EventBus.emit_event(event_save_game, -1, data) #should save everything

func load_game():
	EventBus.emit_event(event_load_game, -1, data) #should load everything

func save_entity(entity_id):
	EventBus.emit_event(event_save_entity, entity_id, data)

func load_entity(entity_id):
	EventBus.emit_event(event_load_entity, entity_id, data)
