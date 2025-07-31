## AIActorComponent replaces InputComponent for AI-controlled actors.
## It selects and runs pluggable Action classes each tick based on blackboard data.

class_name AiActorComponent
extends BaseComponent


# Export a list of Script resources that extend ActionBase
@export var action_resources : Array[Resource]
@export var tick_rate := 1.0

# Internal mapping: action name -> Script class
var _action_scripts := {}              
# Currently running action instance
var _current_action : BaseAction
# Shared data facts for this actor (filled from sensors)
var blackboard := {}


func _ready():
	super()  # BaseComponent._ready() will emit creation events, then call initialize
	get_tree().create_timer(tick_rate).timeout.connect(update())

func initialize(params = {}):
	# Base setup
	super(params)
	# Load all action scripts into a dictionary
	_load_action_scripts()
	# Optionally: subscribe to a global tick or use _process
	set_process(true)
	Debug.Log("AIActorComponent initialized on %d with %d actions." % [owner_id, _action_scripts.size()])

func _load_action_scripts():
	_action_scripts.clear()
	for res in action_resources:
		if res is Script:
			var cls_name = res.get_class()
			_action_scripts[cls_name] = res
		else:
			Debug.Log("[AIActor] Invalid action resource: %s" % str(res))

func update():
	# 1) Update blackboard from EventBus.stateful_data
	_update_blackboard()
	# 2) If no action or finished, pick next
	if _current_action == null or _current_action.is_finished():
		_start_next_action()
	# 3) Tick current action
	if _current_action:
		_current_action.update()

func _update_blackboard():
	# Pull in latest sensed data for this actor
	if EventBus.stateful_data.has(owner_id):
		blackboard = EventBus.stateful_data[owner_id]
	else:
		blackboard = {}

func _start_next_action():
	# Decide what action to run next (placeholder selection)
	var ActionClass = _select_action_class()
	if ActionClass:
		# Clean up previous
		if _current_action:
			_current_action.stop()
		# Instantiate and start new action
		_current_action = ActionClass.new()
		_current_action.start(blackboard)
		Debug.Log("[AIActor] Started action: %s" % _current_action)

func _select_action_class():
	# TODO: replace with GOAP/Utility selection logic
	# For now: pick the first available action
	for cls in _action_scripts.values():
		return cls
	return null

func cleanup():
	# Stop current action if any
	if _current_action:
		_current_action.stop()
	set_process(false)
	super()
