class_name ShieldComponent
extends BaseComponent

var shield : float = 100
var max_shield : float = 100000

var event_entity_hit: String = "entity_hit"
var event_entity_fully_shielded: String = "entity_fully_shielded"
var event_entity_shield_destroyed: String = "entity_shield_destroyed"
var event_shield_changed: String = "shield_changed"

func handle_event(event_name, target_id, event_data):
	super(event_name, target_id, event_data)
	if event_name == event_entity_hit and target_id == owner_id:
		var amount = event_data.get("amount", 0)
		modify_shield(amount)

func modify_shield(amount):
	shield += amount
	if shield >= max_shield:
		shield = max_shield
		update_data()
		EventBus.emit_signal(event_entity_fully_shielded, owner_id, data)
	if shield <= 0:
		shield = 0
		update_data()
		EventBus.emit_signal(event_entity_shield_destroyed, owner_id, data)
	EventBus.emit_event(event_shield_changed, owner_id, data)

func update_data():
	super.update_data()
	data["shield"] = shield
	data["max_shield"] = max_shield
