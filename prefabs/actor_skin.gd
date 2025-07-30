## Actor Skin
## The Actor Skin class is intended to handle the mesh, animations, particles, and other visual
## feedback that is provided to the player. Each skin will be unique, but all will extend from
## this base Actor Skin class, which will provide the base interface on which all interaction via
## code will take place. 

## This is to be treated as an API - any input in is provided by issuing commands to this ActorSkin
## via the EventBus, and all outputs will be sent also via the EventBus, but will mostly be fired
## using animation function calls. 

## Assumptions:
## ActorSkins will always use a State Machine for their Animation Tree
## The State Machine will always include an Idle animation


class_name ActorSkin
extends Node3D

@onready var skin: MeshInstance3D = $Skin
@onready var hitbox: CollisionShape3D = $Hitbox
@onready var hurtbox: CollisionShape3D = $Hurtbox
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: AnimationNodeStateMachine = animation_tree.get_tree_root()
@onready var current_state: AnimationNodeStateMachinePlayback = animation_tree.get(
		"parameters/StateMachine/playback"
)
var owner_entity: Node = null  # Reference to parent/entity
var owner_id: int = -2 #-2 means unassigned

var data: Dictionary = {}
var eventNames
var state_list : Array

func _ready() -> void:
	owner_entity = get_parent()
	owner_id = owner_entity.get_instance_id()
	EventBus.emit_event("component_created", owner_id, data)
	call_deferred("handshake")
	get_states()

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func handle_event(event_name, target_id, event_data):
	if target_id != owner_id:
		return
	if event_name == "do_action" and event_data.has("action_name"):
		do_action(event_data["action_name"])

# This only exists to allow easy access for animation callables. Might be removeable.
func emit_event(event_name, target_id, event_data):
	EventBus.emit_event(event_name, target_id, event_data)

func do_action(action_name: String) -> bool:
	#If doesn't have animation, return false. Else set to animation.
	if not state_list.has(action_name):
		return false
	current_state.travel(action_name)
	return true

func get_states():
	var state_set := {}
	var transition_count := state_machine.get_transition_count()
	for i in transition_count:
		state_set[ state_machine.get_transition_from(i)] = true
		state_set[ state_machine.get_transition_to(i)] = true
	state_list = state_set.keys()

func handshake(): #Set any component behaviors based on other components
	EventBus.emit_event("component_handshake_complete", owner_id, data)
	call_deferred("initialize")

func initialize(params = {}): #Initialize component with current setup
	# Optional: Set up with params
	setup_connections()
	EventBus.emit_event("component_initialized", owner_id, data)

func cleanup():
	# Optional: Clean up before removal
	EventBus.emit_event("component_destroyed", owner_id, data)
	terminate_connections()
	self.queue_free()

func get_owner_entity():
	return owner_entity

func get_owner_class():
	return owner_entity.get_class()

func setup_connections():
	var connected = EventBus.connect("event_emitted", handle_event)
	Debug.Log("Connected " + get_class() + " on " + str(owner_id) + ": " + str(connected))

func terminate_connections():
	EventBus.disconnect("event_emitted", handle_event)
