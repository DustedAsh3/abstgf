## AIActorComponent replaces InputComponent for AI-controlled actors.
## It selects and runs pluggable Action classes each tick based on blackboard data.

class_name AiActorComponent
extends BaseComponent


# Export a list of Script resources that extend ActionBase
@export var action_resources : Array[BaseAction]
@export var tick_rate := 1.0

var _action_list := {}              
# Currently running action instance
var _current_action : BaseAction
var action_data := {}

func _ready():
	super()  # BaseComponent._ready() will emit creation events, then call initialize
	var timer = Utils.CreateTimer(self, tick_rate)
	timer.timeout.connect(update)

func initialize(params = {}):
	# Base setup
	super(params)
	# Load all action scripts into a dictionary
	_load_action_scripts()
	Debug.Log("AIActorComponent initialized on %d with %d actions." % [owner_id, _action_list.size()])

func _load_action_scripts():
	_action_list.clear()
	for act in action_resources:
		if act is BaseAction:
			var cls_name = act.get_class()
			_action_list[cls_name] = act
			Debug.Log("Action List: " + str(_action_list))
		else:
			Debug.Log("[AIActor] Invalid action resource: %s" % str(act))

# This is pretty inefficient. TODO: Refactor to reduce the number of prioritization calls
func update():
	action_data = EventBus.stateful_data[owner_id]
	action_data["AiActorComponent"] = get_instance_id()
	action_data["Owner"] = owner_id
	if _current_action == null or _current_action.is_finished():
		_start_next_action()
		
	if _current_action:
		var prioritized_action = check_priorities()
		if prioritized_action != _current_action and prioritized_action.interruptable:
			_start_next_action()
			return
		_current_action.update(action_data)


func _process(delta: float) -> void:
	if _current_action:
		_current_action._process(delta)

func _start_next_action():
	# Decide what action to run next (placeholder selection)
	var action = check_priorities()
	if action:
		# Clean up previous
		if _current_action:
			_current_action.stop()
		# Instantiate and start new action
		_current_action = action 
		_current_action.start(action_data)


func check_priorities():
	var prioritized_action : BaseAction
	var highest_priority := -1
	for act in _action_list.values():
		var priority = act.get_priority()
		if priority > highest_priority:
			highest_priority = priority
			prioritized_action = act
	return prioritized_action

func cleanup():
	# Stop current action if any
	if _current_action:
		_current_action.stop()
	set_process(false)
	super()
