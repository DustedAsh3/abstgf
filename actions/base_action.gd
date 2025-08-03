class_name BaseAction
extends Resource

var finished := false
var sub_actions: Array = []
var has_sub_action:= false
var ai : AiActorComponent
var owner : Node
var skin : ActorSkin
@export var base_priority := 0
var interruptable := true

func start(context: Dictionary) -> void:    # initialize state, read context (e.g. target_pos)
	if not sub_actions.is_empty():
		has_sub_action = true
	finished = false
	ai = instance_from_id(context["AiActorComponent"])
	owner = instance_from_id(context["Owner"])
	skin = owner.find_child("ActorSkin")

func update(context: Dictionary) -> void:          # drive the behavior each tick
	if has_sub_action:
		if sub_actions.is_empty():
			_on_no_subaction()
		else:
			var current = sub_actions[0]
			current.update()
			if current.is_finished():
				sub_actions.pop_front()

func _process(delta) -> void:
	pass

func is_finished() -> bool:                 # tell AIActor when to pick the next action
	return finished

func stop() -> void:                        # cleanup if pre-empted
	finished = true

func _on_no_subaction():
	finished = true

func get_priority() -> int:
	var priority = base_priority
	return priority
