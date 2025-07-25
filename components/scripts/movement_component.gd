class_name MovementComponent
extends BaseComponent

@export var move_speed: float = 7.5
@export var acceleration: float = 20.0
@export var jump_force: float = 12.0
@export var max_jumps: int = 3
@export var gravity: float = 9.8

var current_velocity: Vector3 = Vector3.ZERO
var jump_count: int = 0
var move_direction: Vector3 = Vector3.ZERO

var event_input: String = "player_input"

func handle_event(event_name, target_id, event_data):
	super(event_name, target_id, event_data)
	if event_name == event_input and target_id == owner_id:
		match event_data["input_type"]:
			"move":
				move_direction = get_direction_vector(event_data.get("direction", Vector2.ZERO))
			"jump":
				jump(event_data)
			"dodge":
				dodge(event_data)

func _physics_process(delta: float) -> void:
	apply_movement(delta)

func apply_movement(delta):
	if not owner_entity or !owner_entity.is_class("CharacterBody3D"):
		data["debug"] = "Owner of movement component is not CharacterBody3D or doesn't exist"
		EventBus.emit_event("error", owner_id, data)
		self.process_mode = Node.PROCESS_MODE_DISABLED
		return
	
	if !owner_entity.is_on_floor():
		owner_entity.velocity.y -= gravity * delta
	
	
	var desired_velocity = Vector3(
		move_direction.x * move_speed,
		owner_entity.velocity.y,
		move_direction.z * move_speed
		)
	
	owner_entity.velocity.x = lerp(owner_entity.velocity.x, desired_velocity.x, acceleration * delta)
	owner_entity.velocity.z = lerp(owner_entity.velocity.z, desired_velocity.z, acceleration * delta)
	
	owner_entity.move_and_slide()
	update_data()

func jump(event_data):
	if can_jump():
		owner_entity.velocity.y = jump_force
		jump_count += 1

func dodge(event_data):
	var dodge_direction = CameraManager.get_forward_vector()
	owner_entity.velocity += dodge_direction * (move_speed * 3)

func can_jump():
	if owner_entity.is_on_floor():
		jump_count = 0
		return true
	elif jump_count < max_jumps:
		return true
	else:
		return false

func get_direction_vector(dir2: Vector2) -> Vector3:
	# Converts input Vector2 (from input) into a Vector3 movement vector based on camera orientation
	# For now, just maps X/Z, later could use camera basis
	var basis = owner_entity.global_transform.basis
	var forward = basis.z.normalized()
	var right = basis.x.normalized()

	# Combine right/forward based on input
	var move_dir = (right * dir2.x) + (forward * dir2.y)
	move_dir.y = 0
	move_dir = move_dir.normalized()
	return Vector3(move_dir.x, 0, move_dir.z)

func update_data():
	super()
	data["global_position"] = owner_entity.global_position
	data["global_rotation"] = owner_entity.global_rotation
	data["velocity"] = current_velocity

func set_to_data(data_in):
	super(data_in)
	owner_entity.global_position = data_in["global_position"]
	owner_entity.global_rotation = data_in["global_rotation"]
	current_velocity = data_in["velocity"]
