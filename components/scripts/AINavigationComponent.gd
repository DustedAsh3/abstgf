class_name AINavigationComponent extends Resource
"""
Advanced AI navigation system for NPCs and enemies.
Essential for believable AI behavior in complex environments.
"""

@export_group("Navigation Behavior")
@export var patrol_enabled: bool = false
@export var patrol_points: Array[Vector3] = []
@export var patrol_order: String = "sequential" # sequential, random, closest
@export var patrol_wait_time: float = 2.0

@export_group("Guard Behavior")
@export var guard_position: Vector3 = Vector3.ZERO
@export var guard_radius: float = 5.0
@export var guard_return_speed: float = 1.0
@export var abandon_guard_distance: float = 20.0

@export_group("Detection and Response")
@export var alert_range: float = 10.0
@export var search_range: float = 15.0
@export var hearing_range: float = 8.0
@export var vision_range: float = 12.0
@export var vision_angle: float = 90.0

@export_group("Pathfinding Preferences")
@export var preferred_paths: Array[Vector3] = []
@export var avoid_areas: Array[AABB] = []
@export var movement_speed_modifier: float = 1.0
@export var can_use_doors: bool = true
@export var can_climb_stairs: bool = true

@export_group("Group Behavior")
@export var group_id: String = ""
@export var follows_leader: bool = false
@export var leader_entity_id: int = -1
@export var formation_position: Vector3 = Vector3.ZERO
@export var group_communication: bool = true
