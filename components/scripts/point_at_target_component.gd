class_name PointAtTargetComponent
extends BaseComponent

@export var target : Node3D

var default_rotation := Vector3.ZERO
var rotation_to_target := Vector3.ZERO

func _ready() -> void:
	super()
	default_rotation = owner_entity.rotation


func handle_event(event_name, target_id, event_data):
	super(event_name, target_id, event_data)
	if event_name == "acquire_target" and target_id == owner_id:
		set_target(event_data)

func set_target(event_data):
	target = event_data.get("target")

func _physics_process(delta: float) -> void:
	if target:
		owner_entity.look_at(target.global_position, Vector3.UP)
	else:
		owner_entity.rotation = Vector3.ZERO
