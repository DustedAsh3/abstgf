extends Node

@export var camera: Camera3D = null
@export var spring_arm: SpringArm3D = null
var follow_target

var yaw = 0.0
var pitch = 0.0
@export var distance = 5.0  # camera distance from player
@export var pitch_min = deg_to_rad(-90)
@export var pitch_max = deg_to_rad(90)
@export var camera_sensitivity = 0.5
@export var invert_x = 1
@export var invert_y = 1

func _ready():
	if camera == null:
		camera = get_tree().get_first_node_in_group("camera")
	if spring_arm == null and camera != null:
		spring_arm = camera.get_parent() as SpringArm3D
	if spring_arm != null:
		follow_target = spring_arm.get_parent()
	else:
		push_error("SpringArm3D not found as camera's parent.")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Debug.Log("Follow Target: " + str(follow_target))

func _input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * 0.01 * camera_sensitivity * invert_x
		pitch -= event.relative.y * 0.01 * camera_sensitivity * invert_y
		pitch = clamp(pitch, pitch_min, pitch_max)
	if event.is_action_pressed("zoom_in"):
		spring_arm.spring_length -= 0.5
		if spring_arm.spring_length <= 1:
			spring_arm.spring_length = 1
	if event.is_action_pressed("zoom_out"):
		spring_arm.spring_length += 0.5
		if spring_arm.spring_length >= 10:
			spring_arm.spring_length = 10

func _process(delta):
	# Apply yaw/pitch to the spring arm (controls camera orbit)
	if spring_arm:
		spring_arm.rotation_degrees.x = rad_to_deg(pitch)
	if follow_target:
		follow_target.rotation_degrees.y = rad_to_deg(yaw)



func set_camera_rotation(event_data):
	pass

func update_camera():
	pass

func set_follow_target(target):
	pass

func apply_shake(strength, duration):
	pass

func transition_to(position, duration):
	pass

func get_forward_vector() -> Vector3:
	var fwd = -camera.global_transform.basis.z
	fwd.y = 0
	return fwd.normalized()

func get_right_vector() -> Vector3:
	var right = camera.global_transform.basis.x
	right.y = 0
	return right.normalized()

func get_camera_relative_direction(input_dir: Vector2) -> Vector3:
	var forward = get_forward_vector()
	var right = get_right_vector()
	var direction = (right * input_dir.x) + (forward * input_dir.y)
	return direction.normalized()
