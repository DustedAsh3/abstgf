class_name DestructableComponent
extends BaseComponent

@export var death_effect: PackedScene

var event_entity_hit: String = "entity_hit"
var event_entity_removed: String = "entity_removed"

func handle_event(event_name, target_id, event_data):
	super(event_name, target_id, event_data)
	if event_name == event_entity_hit and target_id == owner_id:
		destroy(event_data)

func destroy(event_data):
	data["removed_by"] = "Destructable Component"
	data["remover_id"] = self.get_instance_id()
	for comp in owner_entity.get_children():
		if "cleanup" in comp:
			comp.cleanup()
	spawn_death_effects()
	EventBus.emit_event(event_entity_removed, owner_id, data)
	self.terminate_connections()
	if not owner_entity:
		self.queue_free()
		return
	owner_entity.queue_free()


func spawn_death_effects():
	if death_effect:
		var fx = death_effect.instantiate()
		fx.global_transform = owner_entity.global_transform
		var world = get_tree().current_scene.find_child("World")
		if world:
			world.add_child(fx)
		else:
			get_tree().current_scene.add_child(fx)
