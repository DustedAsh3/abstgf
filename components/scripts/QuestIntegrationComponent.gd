class_name QuestIntegrationComponent extends Resource
"""
Integration with quest and narrative systems.
Essential for story-driven dungeon content.
"""

@export_group("Quest Connection")
@export var related_quest_id: String = ""
@export var quest_stage_requirements: Array[String] = []
@export var quest_completion_triggers: Array[String] = []
@export var optional_quest_content: bool = false

@export_group("Narrative Elements")
@export var narrative_importance: String = "minor" # minor, major, critical
@export var story_beats: Array[String] = []
@export var dialogue_triggers: Array[String] = []
@export var lore_content: String = ""

@export_group("Dynamic Content")
@export var adapts_to_player_choices: bool = false
@export var player_choice_responses: Dictionary = {}
@export var branching_content: bool = false
@export var content_variants: Array[String] = []

@export_group("Progress Tracking")
@export var tracks_player_progress: bool = false
@export var progress_checkpoints: Array[String] = []
@export var completion_rewards: Array[String] = []
@export var failure_consequences: Array[String] = []
