class_name CoverComponent extends Resource
"""
Cover system for tactical combat and stealth gameplay.
Essential for strategic AI behavior and player tactics.
"""

@export_group("Cover Properties")
@export var provides_cover: bool = false
@export var cover_type: String = "partial" # partial, full, concealment
@export var cover_height: float = 2.0
@export var cover_width: float = 1.0
@export var cover_durability: int = 100

@export_group("Line of Sight")
@export var blocks_line_of_sight: bool = true
@export var sight_blocking_height: float = 2.0
@export var can_shoot_over: bool = false
@export var can_shoot_around: bool = true
@export var provides_concealment: bool = false

@export_group("Combat Mechanics")
@export var cover_angle_range: float = 90.0 # Degrees of protection
@export var cover_quality: float = 1.0 # 0-1, affects protection
@export var deflects_projectiles: bool = true
@export var absorbs_damage: bool = false
@export var damage_threshold: int = 50

@export_group("AI Usage")
@export var ai_can_use: bool = true
@export var cover_priority: int = 5 # 1-10, AI preference
@export var supports_multiple_users: bool = false
@export var max_occupants: int = 1

@export_group("Dynamic Properties")
@export var destructible_cover: bool = false
@export var degrades_over_time: bool = false
@export var regenerates: bool = false
@export var regeneration_rate: float = 1.0
