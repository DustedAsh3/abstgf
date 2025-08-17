class_name ParticleZoneComponent extends Resource
"""
Advanced particle system for environmental effects and atmosphere.
Essential for visual polish and environmental storytelling.
"""

@export_group("Particle Definition")
@export var particle_type: String = "dust" # dust, steam, smoke, sparkles, fog, rain, snow
@export var particle_scene: PackedScene
@export var particle_material: Material
@export var particle_texture: Texture2D

@export_group("Emission Properties")
@export var emission_rate: float = 10.0
@export var emission_burst_count: int = 0
@export var emission_burst_interval: float = 1.0
@export var emission_randomness: float = 0.0

@export_group("Particle Behavior")
@export var particle_lifetime: float = 5.0
@export var particle_lifetime_variance: float = 1.0
@export var initial_velocity: Vector3 = Vector3.ZERO
@export var velocity_variance: Vector3 = Vector3.ZERO

@export_group("Physics Interaction")
@export var affected_by_gravity: bool = true
@export var gravity_modifier: float = 1.0
@export var affected_by_wind: bool = true
@export var wind_sensitivity: float = 1.0
@export var collision_enabled: bool = false

@export_group("Spatial Properties")
@export var spawn_area: AABB
@export var spawn_shape: String = "box" # box, sphere, cylinder, plane
@export var spawn_on_surface: bool = false
@export var follow_player: bool = false

@export_group("Rendering")
@export var continuous_emission: bool = true
@export var fade_in_time: float = 0.0
@export var fade_out_time: float = 1.0
@export var depth_sorting: bool = true
@export var lighting_affected: bool = true
