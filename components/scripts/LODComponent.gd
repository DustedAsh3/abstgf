class_name LODComponent extends Resource
"""
Level-of-Detail system for performance optimization.
Essential for large dungeons with many detailed objects.
"""

@export_group("LOD Configuration")
@export var use_automatic_lod: bool = true
@export var lod_bias: float = 1.0
@export var current_lod_level: int = 0
@export var max_lod_levels: int = 3

@export_group("Distance Thresholds")
@export var lod_distances: Array[float] = [10.0, 25.0, 50.0] # Distance for each LOD level
@export var hysteresis_factor: float = 1.1 # Prevents LOD flickering
@export var use_screen_size: bool = false
@export var screen_size_thresholds: Array[float] = []

@export_group("LOD Assets")
@export var lod_meshes: Array[Mesh] = []
@export var lod_materials: Array[Material] = []
@export var lod_textures: Array[Texture2D] = []
@export var lod_collision_shapes: Array[Shape3D] = []

@export_group("Transition Settings")
@export var fade_transitions: bool = true
@export var transition_duration: float = 0.5
@export var crossfade_enabled: bool = false
@export var pop_prevention: bool = true

@export_group("Quality Settings")
@export var shadow_lod_enabled: bool = true
@export var lighting_lod_enabled: bool = true
@export var particle_lod_enabled: bool = true
@export var audio_lod_enabled: bool = true
