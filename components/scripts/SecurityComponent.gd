class_name SecurityComponent extends Resource
"""
Security and anti-cheat measures for multiplayer dungeons.
Important for maintaining game integrity.
"""

@export_group("Validation")
@export var server_authoritative: bool = true
@export var validate_positions: bool = true
@export var validate_actions: bool = true
@export var rate_limiting: bool = true

@export_group("Anti-Cheat")
@export var movement_validation: bool = true
@export var speed_limit_enforcement: bool = true
@export var collision_validation: bool = true
@export var action_cooldown_enforcement: bool = true

@export_group("Monitoring")
@export var log_suspicious_activity: bool = true
@export var performance_monitoring: bool = true
@export var player_behavior_tracking: bool = false
@export var anomaly_detection: bool = true
