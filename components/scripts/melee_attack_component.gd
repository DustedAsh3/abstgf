class_name MeleeAttackComponent
extends BaseComponent

# ---- Configurable Data ----
var attack_configs := {} # e.g. { "attack_1": {...}, "default": {...} }
var default_attack_name := "attack_1"
var colliders := {} # name: Node reference

# ---- State ----
var cooldown_timer := 0.0
var is_attacking := false
var hit_targets := []
var animation_player : AnimationPlayer = null
var has_animation := false

func update_data():
	# Extend the base data with melee-specific info
	super()
	data["component_type"] = "MeleeAttackComponent"
	data["attack_configs"] = attack_configs.keys()
	data["has_animation"] = has_animation

func handshake():
	# Try to find animation system
	super()
	animation_player = owner_entity.get_node_or_null("AnimationPlayer")
	has_animation = animation_player != null

	# Find and cache colliders (could be children named e.g. "attack_collider_1")
	for attack_name in attack_configs.keys():
		var collider_name = attack_configs[attack_name].get("collider", "")
		if collider_name != "" and owner_entity.has_node(collider_name):
			colliders[collider_name] = owner_entity.get_node(collider_name)
	# Fallback: grab first Area/CollisionShape if none found
	if colliders.is_empty():
		var first_collider = owner_entity.find_child("CollisionShape3D", true, false)
		if first_collider:
			colliders["default"] = first_collider
	super()

func initialize(params = {}):
	super(params)
	# Reset attack state
	cooldown_timer = 0
	is_attacking = false
	hit_targets.clear()

func _process(delta):
	if cooldown_timer > 0:
		cooldown_timer -= delta
		if cooldown_timer < 0:
			cooldown_timer = 0

# --- Public Method: Attempt Attack ---
func attempt_attack(attack_name = ""):
	if cooldown_timer > 0 or is_attacking:
		return # Can't attack yet

	var name = attack_name if attack_name in attack_configs else default_attack_name
	var config = attack_configs.get(name, attack_configs.get(default_attack_name, {}))

	# Start attack
	is_attacking = true
	hit_targets.clear()
	cooldown_timer = config.get("cooldown", 0.5)
	
	if has_animation:
		animation_player.play(name)
	else:
		# Fallback: immediately activate collider, then call finish after short time
		_activate_collider(config)
		await(get_tree().create_timer(config.get("duration", 0.2))).timeout
		_deactivate_collider(config)
		_finish_attack()

# --- Animation Event Hooks (to be called from AnimationPlayer Call Method Track) ---
func activate_collider(attack_name = ""):
	var config = attack_configs.get(attack_name, attack_configs.get(default_attack_name, {}))
	_activate_collider(config)

func deactivate_collider(attack_name = ""):
	var config = attack_configs.get(attack_name, attack_configs.get(default_attack_name, {}))
	_deactivate_collider(config)
	_finish_attack()

# --- Collider Management ---
func _activate_collider(config):
	var collider_name = config.get("collider", "default")
	var collider = colliders.get(collider_name)
	if collider:
		collider.disabled = false
		collider.connect("body_entered", self, "_on_body_entered", [config])
		# Optionally, set collider size/position from config here

func _deactivate_collider(config):
	var collider_name = config.get("collider", "default")
	var collider = colliders.get(collider_name)
	if collider:
		collider.disabled = true
		collider.disconnect("body_entered", self, "_on_body_entered")

func _finish_attack():
	is_attacking = false
	hit_targets.clear()
	EventBus.emit_event("melee_attack_finished", owner_id, data)

# --- Collider Hit Callback ---
func _on_body_entered(body, config):
	if body in hit_targets:
		return
	hit_targets.append(body)
	# Apply damage/event to the hit target
	var damage = config.get("damage", 5)
	EventBus.emit_event("apply_damage", body.get_instance_id(), {"amount": damage, "source": owner_id})
	EventBus.emit_event("melee_attack_hit", owner_id, {"target": body.get_instance_id(), "attack_data": config})

# --- Event System Integration ---
func handle_event(event_name, target_id, event_data):
	if target_id != owner_id:
		return
	super(event_name, target_id, event_data)
	# Listen for standardized attack events
	if event_name == "melee_attack":
		var attack_name = event_data.get("attack_name", default_attack_name)
		attempt_attack(attack_name)
