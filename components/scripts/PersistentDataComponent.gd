class_name PersistentDataComponent extends Resource
"""
Comprehensive save/load system for maintaining dungeon state.
Critical for persistent world features and player progress.
"""

@export_group("Persistence Settings")
@export var save_state: bool = true
@export var unique_id: String = ""
@export var persistence_level: String = "full" # minimal, partial, full
@export var save_frequency: String = "on_change" # on_change, timed, manual

@export_group("Data Categories")
@export var save_transform: bool = true
@export var save_properties: Array[String] = []
@export var save_component_state: bool = true
@export var save_relationships: bool = false
@export var save_history: bool = false

@export_group("Loading Behavior")
@export var load_priority: int = 0
@export var lazy_loading: bool = false
@export var load_dependencies: Array[String] = []
@export var verify_integrity: bool = true

@export_group("Data Management")
@export var compression_enabled: bool = true
@export var encryption_enabled: bool = false
@export var backup_copies: int = 3
@export var cleanup_old_data: bool = true

@export_group("State Tracking")
@export var state_data: Dictionary = {}
@export var change_tracking: bool = true
@export var dirty_flags: Array[String] = []
@export var last_save_time: float = 0.0
