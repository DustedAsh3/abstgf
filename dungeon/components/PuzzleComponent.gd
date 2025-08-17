class_name PuzzleComponent extends Resource
"""
Comprehensive puzzle system for creating interactive challenges.
Essential for engaging gameplay beyond simple combat.
"""

@export_group("Puzzle Definition")
@export var puzzle_type: String = "pressure_plate" # pressure_plate, lever, crystal, sequence, riddle, combination
@export var puzzle_id: String = ""
@export var puzzle_difficulty: int = 1 # 1-10 scale
@export var puzzle_category: String = "mechanical" # mechanical, magical, logical, physical

@export_group("Solution Requirements")
@export var required_items: Array[String] = []
@export var required_characters: int = 1 # How many players needed
@export var solution_sequence: Array[String] = []
@export var solution_order_matters: bool = true
@export var time_limit: float = 0.0 # 0 = no limit

@export_group("State Management")
@export var is_solved: bool = false
@export var can_be_reset: bool = true
@export var reset_on_failure: bool = true
@export var failure_penalty: bool = false
@export var max_attempts: int = -1 # -1 = unlimited

@export_group("Rewards and Consequences")
@export var success_reward_scene: PackedScene
@export var success_items: Array[String] = []
@export var success_events: Array[String] = []
@export var failure_consequence: String = ""
@export var failure_damage: int = 0
@export var failure_events: Array[String] = []

@export_group("Visual Feedback")
@export var progress_indicator: bool = true
@export var hint_system: bool = false
@export var hint_unlock_time: float = 30.0
@export var completion_effect: PackedScene
