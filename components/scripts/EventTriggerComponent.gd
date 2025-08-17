class_name EventTriggerComponent extends Resource
"""
Sophisticated event system for complex dungeon interactions.
Foundation for all dynamic behaviors and scripted sequences.
"""

@export_group("Event Definition")
@export var trigger_events: Array[String] = []
@export var listen_events: Array[String] = []
@export var event_namespace: String = "global"
@export var event_priority: int = 0

@export_group("Trigger Conditions")
@export var trigger_type: String = "immediate" # immediate, delayed, conditional, probabilistic
@export var trigger_delay: float = 0.0
@export var trigger_probability: float = 1.0
@export var trigger_conditions: Dictionary = {}

@export_group("Event Filtering")
@export var event_filters: Dictionary = {} # event_name -> filter_conditions
@export var source_filters: Array[String] = [] # Only listen to specific sources
@export var parameter_requirements: Dictionary = {}

@export_group("Response Behavior")
@export var response_type: String = "immediate" # immediate, queued, batched
@export var response_delay: float = 0.0
@export var event_responses: Dictionary = {} # event_name -> response_data
@export var cascade_events: bool = false

@export_group("Limitations")
@export var cooldown_time: float = 0.0
@export var max_triggers: int = -1 # -1 = unlimited
@export var max_triggers_per_event: Dictionary = {} # event -> max_count
@export var reset_conditions: Array[String] = []

@export_group("Debugging")
@export var log_events: bool = false
@export var debug_visualization: bool = false
@export var event_history: Array[Dictionary] = []
@export var performance_tracking: bool = false
