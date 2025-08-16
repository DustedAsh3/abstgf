# MoveToPointAction.gd
class_name MoveToPointAction
extends BaseAction

@export var arrive_radius: float = 0.6
@export var slow_radius: float = 2.5
@export var face_while_moving: bool = true

var forward_command: Vector2 = Vector2(0, 1)
var _mc: MovementComponent
var _vision: VisionComponent
var _owner_body: CharacterBody3D
var _target_pos: Vector3 = Vector3.ZERO

func start(context: Dictionary) -> void:
	super(context)

	# Require MovementComponent
	_mc = _find_movement_component(owner)
	if _mc == null:
		finished = true
		return

	# Require CharacterBody3D
	if owner and owner.is_class("CharacterBody3D"):
		_owner_body = owner
	else:
		finished = true
		return

	# Find VisionComponent to read sensor keys/offsets
	_vision = _find_vision_component(owner)
	if _vision == null:
		finished = true
		return

	# Prime a target from current vision; if none, deny
	if not _acquire_target():
		finished = true
		return

	finished = false

func update(context: Dictionary) -> void:
	if finished:
		return

	# Refresh target selection each tick (handles target moving / list changes)
	if not _acquire_target():
		# nothing visible -> stop and finish
		EventBus.emit_event("entity_input", _mc.owner_id, {
			"input_type": "move",
			"direction": Vector2.ZERO
		})
		finished = true
		return

	var to_target := _horizontal_delta(_owner_body.global_position, _target_pos)
	var dist := to_target.length()

	# Arrived?
	if dist <= arrive_radius:
		EventBus.emit_event("entity_input", _mc.owner_id, {
			"input_type": "move",
			"direction": Vector2.ZERO
		})
		finished = true
		return

	# Ease inside slow radius (let MovementComponent accel handle smoothing)
	var scale := 1.0
	if dist < slow_radius:
		scale = clamp(dist / slow_radius, 0.2, 1.0)

	EventBus.emit_event("entity_input", _mc.owner_id, {
		"input_type": "move",
		"direction": Vector2(forward_command.x * scale, forward_command.y * scale)
	})

func _process(delta: float) -> void:
	if finished or !face_while_moving or _owner_body == null:
		return
	# Yaw-only alignment toward current target
	var from := _owner_body.global_transform.origin
	var look := Vector3(_target_pos.x, from.y, _target_pos.z)
	if from.distance_to(look) > 0.001:
		_owner_body.look_at(look, Vector3.UP)

func stop() -> void:
	# Clean stop when interrupted
	if _mc:
		EventBus.emit_event("entity_input", _mc.owner_id, {
			"input_type": "move",
			"direction": Vector2.ZERO
		})
	super()

func is_finished() -> bool:
	return finished

func get_priority(context: Dictionary = {}) -> int:
	# Deny if no movement or no vision or no visible bodies
	if owner == null: return -1
	if _find_movement_component(owner) == null: return -1
	var v := _find_vision_component(owner)
	if v == null: return -1

	if not EventBus.stateful_data.has(owner.get_instance_id()):
		return -1
	var bb = EventBus.stateful_data[owner].instance_from_id()

	if !bb.has(v.sensor_key): return -1
	if (bb[v.sensor_key] as Array).is_empty(): return -1

	# If already very close to nearest visible, also deprioritize
	var nearest := _closest_visible_position(bb[v.sensor_key], v)
	if nearest == null: return -1
	var d := _horizontal_delta(owner.global_position, nearest).length()
	if d <= arrive_radius: return -1

	return base_priority

# ---------- helpers ----------

func _acquire_target() -> bool:
	# Pull latest visible IDs from vision's sensor list
	if !EventBus.stateful_data.has(owner.get_instance_id()):
		return false
	var bb = EventBus.stateful_data[owner].instance_from_id()
	if !bb.has(_vision.sensor_key):
		return false
	var visible: Array = bb[_vision.sensor_key]
	if visible.is_empty():
		return false

	var pos := _closest_visible_position(visible, _vision)
	if pos == null:
		return false
	_target_pos = pos
	return true

func _closest_visible_position(visible: Array, vision: VisionComponent) -> Vector3:
	var best_dist := INF
	var best_pos: Vector3 = Vector3.ZERO
	var have := false
	for body_id in visible:
		var node := instance_from_id(body_id)
		if node == null: 
			continue
		var candidate : Vector3 = node.global_transform.origin + vision.look_offset
		var d := _horizontal_delta(_owner_body.global_position, candidate).length()
		if d < best_dist:
			best_dist = d
			best_pos = candidate
			have = true
	return best_pos if have else null

func _find_movement_component(node: Node) -> MovementComponent:
	for child in node.get_children():
		if child is MovementComponent:
			return child
	return null

func _find_vision_component(node: Node) -> VisionComponent:
	for child in node.get_children():
		if child is VisionComponent:
			return child
	return null

func _horizontal_delta(from: Vector3, to: Vector3) -> Vector3:
	var d := to - from
	d.y = 0.0
	return d
