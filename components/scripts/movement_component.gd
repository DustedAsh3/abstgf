class_name MovementComponent
extends BaseComponent

@export var move_speed: float = 7.5
@export var acceleration: float = 20.0
@export var jump_force: float = 12.0
@export var max_jumps: int = 3
@export var gravity: float = 9.8
@export var is_player: bool = false

var current_velocity: Vector3 = Vector3.ZERO
var jump_count: int = 0
var move_direction: Vector3 = Vector3.ZERO
var input_direction : Vector2 = Vector2.ZERO

var event_input: String = "entity_input"

func handle_event(event_name, target_id, event_data):
	super(event_name, target_id, event_data)
	if event_name == event_input and target_id == owner_id:
		match event_data["input_type"]:
			"move":
				input_direction = event_data.get("direction", Vector2.ZERO)
			"jump":
				jump(event_data)
			"dodge":
				dodge(event_data)

func _physics_process(delta: float) -> void:
	apply_movement(delta)

func apply_movement(delta):
	if not owner_entity or !owner_entity.is_class("CharacterBody3D"):
		data["debug"] = "Owner of movement component is not CharacterBody3D or doesn't exist"
		data["owner_class"] = owner_entity.get_class()
		EventBus.emit_event("error", owner_id, data)
		self.process_mode = Node.PROCESS_MODE_DISABLED
		return
	
	if is_player: move_direction = CameraManager.get_camera_relative_direction(input_direction)
	else: move_direction = get_relative_direction(input_direction)
	
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

func jump(event_data): #input_type
	if can_jump():
		owner_entity.velocity.y = jump_force
		jump_count += 1

func dodge(event_data):
	var dodge_direction = -CameraManager.get_forward_vector()
	owner_entity.velocity += dodge_direction * (move_speed * 30)

func can_jump():
	if owner_entity.is_on_floor():
		jump_count = 0
		return true
	elif jump_count < max_jumps:
		return true
	else:
		return false

func update_data():
	super()
	data["global_position"] = owner_entity.global_position
	data["global_rotation"] = owner_entity.global_rotation
	data["velocity"] = current_velocity

func bind_blackboard():
	owner_entity.bt_player.blackboard.bind_var_to_property("position", owner_entity, "global_position", true)
	owner_entity.bt_player.blackboard.bind_var_to_property("rotation", owner_entity, "global_rotation", true)
	owner_entity.bt_player.blackboard.bind_var_to_property("velocity", self, "current_velocity", true)


func set_to_data(data_in):
	super(data_in)
	owner_entity.global_position = data_in["global_position"]
	owner_entity.global_rotation = data_in["global_rotation"]
	current_velocity = data_in["velocity"]

func get_relative_direction(input_direction: Vector2) -> Vector3:
	var forward_direction = -owner_entity.global_transform.basis.z.normalized()
	forward_direction.x = forward_direction.x * input_direction.x
	forward_direction.z = forward_direction.z * input_direction.y
	return forward_direction
