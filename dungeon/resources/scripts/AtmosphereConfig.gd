class_name AtmosphereConfig extends Resource
"""
Creates immersive environmental atmosphere for rooms and areas.
Transforms sterile geometry into living, breathing environments.
"""

@export_group("Audio Atmosphere")
@export var ambient_sound: AudioStream
@export var ambient_volume: float = 0.5
@export var ambient_pitch_variation: float = 0.1
@export var echo_enabled: bool = false
@export var reverb_preset: AudioManager.ReverbPreset = AudioManager.ReverbPreset.NORMAL

@export_group("Visual Effects")
@export var particle_system: PackedScene
@export var fog_enabled: bool = false
@export var fog_color: Color = Color.WHITE
@export var fog_density: float = 0.01
@export var fog_height_falloff: float = 0.1

@export_group("Environmental Conditions")
@export var temperature: float = 20.0 # Celsius
@export var humidity: float = 50.0 # Percentage
@export var air_pressure: float = 1.0 # Atmospheric pressure
@export var wind_strength: float = 0.0
@export var wind_direction: Vector3 = Vector3.ZERO

@export_group("Lighting Atmosphere")
@export var ambient_light_color: Color = Color.WHITE
@export var ambient_light_intensity: float = 0.3
@export var shadow_color_tint: Color = Color.BLUE
@export var light_scattering: float = 0.1

@export_group("Time and Weather")
@export var time_of_day_affects: bool = false
@export var weather_affects: bool = false
@export var seasonal_variation: bool = false
