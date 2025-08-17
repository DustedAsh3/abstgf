class_name BiomeGenerationComponent extends Resource
"""
Biome-specific generation rules that create thematic consistency.
Essential for creating distinct visual and gameplay experiences.
"""

@export_group("Biome Identity")
@export var biome_type: BiomeTypes.BiomeType
@export var biome_name: String = ""
@export var biome_description: String = ""
@export var difficulty_modifier: float = 1.0

@export_group("Material Palette")
@export var wall_materials: Array[Material] = []
@export var floor_materials: Array[Material] = []
@export var ceiling_materials: Array[Material] = []
@export var door_materials: Array[Material] = []
@export var accent_materials: Array[Material] = []

@export_group("Feature Generation Rules")
@export var feature_spawn_rules: Dictionary = {} # feature_type -> spawn_probability
@export var feature_density_modifier: float = 1.0
@export var exclusive_features: Array[String] = [] # Features only in this biome
@export var forbidden_features: Array[String] = [] # Features never in this biome

@export_group("Enemy and Loot Rules")
@export var enemy_spawn_rules: Dictionary = {} # enemy_type -> spawn_data
@export var loot_table_modifier: Dictionary = {} # rarity -> probability_modifier
@export var special_encounters: Array[String] = []

@export_group("Environmental Rules")
@export var lighting_preferences: Dictionary = {} # light_type -> preference_weight
@export var atmospheric_effects: Array[String] = []
@export var sound_theme: AudioStream
@export var particle_effects: Array[PackedScene] = []

@export_group("Generation Constraints")
@export var room_size_preferences: Dictionary = {} # size_category -> preference
@export var corridor_style_preferences: Array[String] = []
@export var vertical_variation: bool = false
@export var allows_multi_level: bool = true
