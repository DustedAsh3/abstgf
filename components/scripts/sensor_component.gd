## Sensor Component
## A Sensor Component is a read-only component that emits data based on the shape of it's sensor
## and the key it uses. As a design standard, this component is useless on it's own. It is intended
## to be extended with an actual implementation of different kinds of sensors, such as vision and
## hearing. 

## Sensors use the EventBus's Stateful_Data component to hold their data, since their data will be
## constantly and rapidly changing from moment to moment, and relying on base signals may not
## always provide the most up to date information. 

class_name SensorComponent
extends Area3D

@export var sensor_key: String ## Name of sensor stored in the EventBus

@onready var sensor_shape: CollisionShape3D = $SensorShape

var owner_entity: Node = null  # Reference to parent/entity
var owner_actor: Node = null # Reference to parent/actor
var owner_id: int = -2 #-2 means unassigned
var actor_id: int = -3 #-3 means unassigned

func _ready():
	owner_entity = get_parent().get_parent() #Get the Entity, not the Actor
	owner_actor = get_parent() #Get the Actor
	owner_id = owner_entity.get_instance_id()
	actor_id = owner_actor.get_instance_id()
	EventBus.register_sensor(owner_id, sensor_key, get_instance_id())
	connect("body_entered", _on_entered)
	connect("body_exited", _on_exited)

func _on_entered(body: Node3D):
	if body.get_class() == "CharacterBody3D":
		EventBus.stateful_data[owner_id][sensor_key].append(body.get_instance_id())

func _on_exited(body):
	EventBus.stateful_data[owner_id][sensor_key].erase(body.get_instance_id())
