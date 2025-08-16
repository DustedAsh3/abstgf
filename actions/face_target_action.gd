class_name FaceTargetAction
extends BaseAction

var target_id := -1
var targets : Array
var target : Node3D
var look_target := Vector3.FORWARD
var facing := Vector3.FORWARD
var look_speed := 0.25


func start(context: Dictionary) -> void:
	super(context)
	targets = context.get("in_sight")
	if targets.is_empty():
		stop() # No Target Provided. Not a valid action.
		return
	target_id = targets[0]
	target = instance_from_id(target_id)
	Debug.Log(str(context))

func update(context: Dictionary) -> void:
	super(context)
	targets = context.get("in_sight")
	if target_id == -1 or targets.is_empty():
		stop()
		return
	if target.get_instance_id() != target_id:
		#Target Changed
		set_local_data(context)
	look_target = target.global_position

func _process(delta) -> void:
	super(delta)
	if facing != look_target:
		facing = lerp(facing, look_target, look_speed)
	skin.look_at(facing, Vector3.UP, true)

func set_local_data(context: Dictionary):
	target = instance_from_id(target_id)
	ai = instance_from_id(context["AiActorComponent"])
	owner = instance_from_id(context["Owner"])
	skin = owner.find_child("ActorSkin")

func stop():
	super()
	target = null
	look_target = Vector3.FORWARD

func get_priority(context: Dictionary = {}) -> int:
	var priority = super()
	if target:
		priority += 1
	return priority
