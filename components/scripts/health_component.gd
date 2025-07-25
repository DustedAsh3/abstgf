class_name HealthComponent
extends BaseComponent

var health : float = 3
var max_health : float = 3

var event_entity_hit: String = "entity_hit"
var event_entity_fully_healed: String = "entity_fully_healed"
var event_entity_killed: String = "entity_killed"
var event_health_changed: String = "health_changed"

func handshake():
	super()
	var target = owner_entity.get_node_or_null("DestructableComponent")
	if target:
		modify_event(target, "event_entity_hit", event_entity_killed)

func handle_event(event_name, target_id, event_data):
	super(event_name, target_id, event_data)
	if event_name == event_entity_hit and target_id == owner_id:
		var amount = event_data.get("amount", 0)
		modify_health(amount)

func modify_health(amount):
	health += amount
	if health >= max_health:
		health = max_health
		update_data()
		EventBus.emit_signal(event_entity_fully_healed, owner_id, data)
	if health <= 0:
		health = 0
		update_data()
		EventBus.emit_signal(event_entity_killed, owner_id, data)
	EventBus.emit_event(event_health_changed, owner_id, data)

func update_data():
	super.update_data()
	data["health"] = health
	data["max_health"] = max_health
