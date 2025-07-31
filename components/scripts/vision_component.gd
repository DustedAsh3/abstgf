class_name VisionComponent
extends SensorComponent

@export var sight_tick_rate := 0.1
@export var eye_offset := Vector3(0, 1.6, 0) # Head Height
@export var look_offset := Vector3(0, 0.5, 0) # Default Look Height
@onready var sight_tick_timer: Timer = $SightTick

var obstructed_key : String

func _ready():
	super()
	obstructed_key = sensor_key + "obstructed"
	sight_tick_timer.wait_time = sight_tick_rate
	sight_tick_timer.timeout.connect(cast_rays)
	EventBus.register_sensor(owner_id, obstructed_key, get_instance_id())

func _on_entered(body):
	super(body)
	start_cast_rays(body)

func _on_exited(body):
	super(body)
	stop_cast_rays(body)

func start_cast_rays(body):
	if sight_tick_timer.is_stopped(): #Now have at least one body in sight, start timer.
		cast_rays() #Have to start with a cast otherwise the sensor doesn't detect until the first cycle
		sight_tick_timer.start()

func stop_cast_rays(body):
	if EventBus.stateful_data[owner_id][sensor_key].is_empty() and EventBus.stateful_data[owner_id][obstructed_key].is_empty(): #No Bodies in sight. Stop timer.
		sight_tick_timer.stop()

func cast_rays():
	for body in EventBus.stateful_data[owner_id][sensor_key]:
		var target_found := false
		var from = global_transform.origin + eye_offset
		var to = instance_from_id(body).global_transform.origin + look_offset
		var space = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		query.set_exclude([self, owner_actor, owner_entity])
		var collision = space.intersect_ray(query)
		if collision.is_empty(): #
			Debug.Log("Cast rays, but no collision was registered!" + str(owner_id) + ", Vision Component")
		if collision.has("collider_id"):
			if collision["collider_id"] != body:
				EventBus.stateful_data[owner_id][obstructed_key].append(body)
				if EventBus.stateful_data[owner_id][sensor_key].has(body):
					EventBus.stateful_data[owner_id][sensor_key].erase(body)
			elif not EventBus.stateful_data[owner_id][sensor_key].has(body):
				EventBus.stateful_data[owner_id][sensor_key].append(body)
				if EventBus.stateful_data[owner_id][obstructed_key].has(body):
					EventBus.stateful_data[owner_id][obstructed_key].erase(body)
