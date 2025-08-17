class_name RoomTemplateComponent extends Resource
"""
Pre-designed room layouts for specific purposes and themes.
Ensures consistent quality and purposeful design in generated content.
"""

@export_group("Template Definition")
@export var template_name: String = ""
@export var template_id: String = ""
@export var template_type: RoomTypes.RoomType
@export var template_theme: String = "generic" # generic, throne, library, armory, prison, ritual

@export_group("Size Requirements")
@export var required_size: Vector3i
@export var size_tolerance: Vector3i = Vector3i.ZERO # Flexibility in sizing
@export var aspect_ratio_locked: bool = false
@export var minimum_height: float = 3.0

@export_group("Layout Definition")
@export var floor_pattern: Array[Vector3i] = [] # Custom floor tiles
@export var wall_pattern: Array[Vector3i] = [] # Custom wall placements
@export var ceiling_pattern: Array[Vector3i] = [] # Custom ceiling elements
@export var foundation_required: bool = true

@export_group("Feature Placement")
@export var feature_positions: Dictionary = {} # feature_type -> Array[Vector3i]
@export var door_positions: Array[Vector3i] = []
@export var window_positions: Array[Vector3i] = []
@export var pillar_positions: Array[Vector3i] = []

@export_group("Spawn and Interaction Points")
@export var player_spawn_positions: Array[Vector3i] = []
@export var enemy_spawn_positions: Array[Vector3i] = []
@export var loot_spawn_positions: Array[Vector3i] = []
@export var interaction_points: Array[Vector3i] = []

@export_group("Requirements and Rules")
@export var mandatory_features: Array[String] = []
@export var optional_features: Array[String] = []
@export var forbidden_features: Array[String] = []
@export var required_connections: int = 1
@export var max_connections: int = 4

@export_group("Variation System")
@export var has_variants: bool = false
@export var variant_templates: Array[RoomTemplateComponent] = []
@export var variant_selection_weights: Array[float] = []
