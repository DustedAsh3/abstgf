class_name PlayerStateComponent
extends BaseComponent

enum status_types{ALIVE, STUNNED, DEAD}

var status : status_types
var is_shielded : bool
var is_player_controlled : bool
var event_entity_hit: String = "entity_hit"
var event_shield_changed: String = "shield_changed"
var event_modify_health: String = "modify_health"
var event_modify_shield: String = "modify_shield"

func handshake():
	var target = owner_entity.get_node_or_null("HealthComponent")
	if target:
		modify_event(target, "event_entity_hit", event_modify_health)
	target = owner_entity.get_node_or_null("ShieldComponent")
	if target:
		modify_event(target, "event_entity_hit", event_modify_shield)
	super.handshake()


func handle_event(event_name, target_id, event_data):
	super(event_name, target_id, event_data)
	if event_name == event_entity_hit and target_id == owner_id:
		var amount = event_data.get("amount", 0)
		handle_hit(amount)
	if event_name == event_shield_changed and target_id == owner_id:
		data["shield"] = event_data["shield"]

func handle_hit(amount):
	data["amount"] = amount
	if is_shielded and data["shield"] > 0:
		EventBus.emit_event(event_modify_shield, owner_id, data)
	else:
		EventBus.emit_event(event_modify_health, owner_id, data)
	data["amount"] = 0

func update_data():
	data["status"] = status
	data["is_shielded"] = is_shielded
	data["is_player_controlled"] = is_player_controlled
	super.update_data()
