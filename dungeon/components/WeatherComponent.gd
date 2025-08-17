class_name WeatherComponent extends Resource
"""
Dynamic weather system that affects gameplay and atmosphere.
Adds environmental variety and strategic elements.
"""

@export_group("Weather Definition")
@export var weather_type: String = "none" # none, rain, snow, fog, storm, sandstorm, hail
@export var weather_intensity: float = 1.0
@export var weather_duration: float = -1.0 # -1 = permanent
@export var weather_transition_time: float = 30.0

@export_group("Visual Effects")
@export var particle_effect: PackedScene
@export var particle_density: float = 1.0
@export var sky_color_tint: Color = Color.WHITE
@export var lighting_modifier: Color = Color.WHITE
@export var fog_density_modifier: float = 1.0

@export_group("Gameplay Effects")
@export var affects_visibility: bool = false
@export var visibility_range: float = 20.0
@export var affects_movement: bool = false
@export var movement_speed_modifier: float = 1.0
@export var affects_accuracy: bool = false

@export_group("Audio Effects")
@export var weather_sound: AudioStream
@export var weather_sound_volume: float = 0.5
@export var thunder_sounds: Array[AudioStream] = []
@export var thunder_frequency: float = 0.1

@export_group("Environmental Impact")
@export var temperature_change: float = 0.0
@export var humidity_change: float = 0.0
@export var creates_puddles: bool = false
@export var extinguishes_fires: bool = false
