class_name AudioZoneComponent extends Resource
"""
Sophisticated 3D audio system that creates immersive soundscapes.
Critical for atmosphere and player immersion.
"""

@export_group("Music System")
@export var background_music: AudioStream
@export var music_volume: float = 0.5
@export var music_fade_distance: float = 10.0
@export var adaptive_music: bool = false
@export var combat_music: AudioStream
@export var exploration_music: AudioStream

@export_group("Ambient Soundscape")
@export var ambient_sounds: Array[AudioStream] = []
@export var ambient_volumes: Array[float] = []
@export var ambient_loop_points: Array[Vector2] = [] # start, end times
@export var layered_ambience: bool = true

@export_group("Interactive Audio")
@export var footstep_override: bool = false
@export var footstep_sounds: Dictionary = {} # material_type -> AudioStream
@export var movement_sounds: Dictionary = {} # action -> AudioStream
@export var interaction_feedback: Dictionary = {} # interaction -> AudioStream

@export_group("Spatial Audio")
@export var use_3d_positioning: bool = true
@export var max_distance: float = 50.0
@export var attenuation_model: String = "inverse_distance" # linear, inverse, exponential
@export var doppler_enabled: bool = false

@export_group("Environmental Audio")
@export var echo_enabled: bool = false
@export var reverb_settings: AudioEffectReverb
@export var occlusion_enabled: bool = false
@export var sound_barriers: Array[AABB] = []

@export_group("Dynamic Response")
@export var responds_to_time: bool = false
@export var responds_to_weather: bool = false
@export var responds_to_events: bool = false
@export var event_audio_map: Dictionary = {} # event -> AudioStream
