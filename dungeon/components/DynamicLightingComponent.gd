class_name DynamicLightingComponent extends Resource
"""
Advanced lighting effects that respond to events and create atmosphere.
Essential for creating mood and visual interest.
"""

@export_group("Flicker Effects")
@export var flicker_enabled: bool = false
@export var flicker_intensity_min: float = 0.8
@export var flicker_intensity_max: float = 1.2
@export var flicker_speed: float = 1.0
@export var flicker_pattern: String = "random" # random, heartbeat, flame, electrical

@export_group("Color Animation")
@export var color_cycling: bool = false
@export var cycle_colors: Array[Color] = []
@export var cycle_speed: float = 1.0
@export var color_transition_type: String = "smooth" # smooth, sharp, pulse

@export_group("Event Response")
@export var responds_to_events: bool = false
@export var event_triggers: Dictionary = {} # event_name -> light_response
@export var proximity_dimming: bool = false
@export var proximity_range: float = 5.0

@export_group("Advanced Effects")
@export var casts_moving_shadows: bool = false
@export var shadow_dance_speed: float = 1.0
@export var projects_patterns: bool = false
@export var projection_texture: Texture2D
