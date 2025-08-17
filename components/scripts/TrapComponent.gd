class_name TrapComponent extends Resource
"""
Sophisticated trap system with various trigger types and effects.
Adds danger and strategic thinking to dungeon exploration.
"""

@export_group("Trap Definition")
@export var trap_type: String = "spike" # spike, arrow, gas, magic, pit, crushing, fire, ice, lightning
@export var trap_subtype: String = "basic" # basic, advanced, magical, mechanical
@export var trap_difficulty: int = 1 # Detection and disarm difficulty

@export_group("Trigger System")
@export var trigger_type: String = "step" # step, proximity, timed, remote, manual, magical
@export var trigger_range: float = 1.0
@export var trigger_weight_threshold: float = 50.0 # kg
@export var trigger_delay: float = 0.5
@export var multiple_triggers: bool = false

@export_group("Damage and Effects")
@export var damage_amount: int = 25
@export var damage_type: String = "physical" # physical, fire, ice, poison, magical
@export var area_of_effect: float = 0.0 # 0 = single target
@export var knockback_force: float = 0.0
@export var status_effects: Array[String] = [] # poison, slow, stun, etc.

@export_group("Behavior")
@export var is_armed: bool = true
@export var reset_time: float = 3.0
@export var max_triggers: int = -1 # -1 = unlimited
@export var can_be_disarmed: bool = true
@export var disarm_difficulty: int = 5

@export_group("Warning System")
@export var visual_warning: bool = false
@export var audio_warning: AudioStream
@export var warning_duration: float = 1.0
@export var detection_skill_check: bool = true
