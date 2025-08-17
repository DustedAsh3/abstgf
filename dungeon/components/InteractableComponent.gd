class_name InteractableComponent extends Resource
"""
General-purpose interaction system for objects, NPCs, and mechanisms.
Foundation for all player-object interactions.
"""

@export_group("Interaction Properties")
@export var interaction_type: String = "examine" # examine, pickup, activate, talk, use, craft, read
@export var interaction_verb: String = "interact with" # Custom verb for UI
@export var interaction_text: String = "Press E to interact"
@export var interaction_icon: Texture2D

@export_group("Requirements")
@export var requires_item: String = ""
@export var consumes_item: bool = false
@export var requires_skill: String = ""
@export var skill_difficulty: int = 0
@export var requires_quest_stage: String = ""

@export_group("Behavior")
@export var interaction_range: float = 2.0
@export var line_of_sight_required: bool = true
@export var cooldown_time: float = 0.0
@export var use_count: int = -1 # -1 = unlimited
@export var breaks_after_use: bool = false

@export_group("Feedback")
@export var interaction_sound: AudioStream
@export var interaction_animation: String = ""
@export var success_message: String = ""
@export var failure_message: String = ""
@export var interaction_effect: PackedScene

@export_group("Results")
@export var gives_item: String = ""
@export var gives_experience: int = 0
@export var triggers_event: String = ""
@export var opens_dialogue: String = ""
@export var activates_mechanism: String = ""
