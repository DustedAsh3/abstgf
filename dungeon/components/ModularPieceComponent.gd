class_name ModularPieceComponent extends Resource
"""
Modular construction system for flexible dungeon assembly.
Enables kit-based generation and architectural consistency.
"""

@export_group("Piece Definition")
@export var piece_type: String = "wall_segment"
@export var piece_category: String = "structural" # structural, decorative, functional
@export var piece_id: String = ""
@export var architectural_style: String = "medieval"

@export_group("Connection System")
@export var connection_points: Array[Vector3] = []
@export var connection_types: Array[String] = [] # male, female, universal
@export var connection_orientations: Array[Vector3] = []
@export var required_connections: int = 1
@export var max_connections: int = 4

@export_group("Compatibility")
@export var compatible_pieces: Array[String] = []
@export var incompatible_pieces: Array[String] = []
@export var style_compatibility: Array[String] = []
@export var size_compatibility: Dictionary = {}

@export_group("Transformation Rules")
@export var rotation_allowed: bool = true
@export var rotation_increments: float = 90.0 # Degrees
@export var mirror_allowed: bool = false
@export var scale_allowed: bool = false
@export var scale_range: Vector2 = Vector2(0.5, 2.0)

@export_group("Placement Rules")
@export var snap_to_grid: bool = true
@export var grid_alignment: Vector3 = Vector3.ONE
@export var elevation_rules: Dictionary = {} # height_level -> placement_rules
@export var spacing_requirements: Dictionary = {}

@export_group("Validation")
@export var structural_integrity: bool = true
@export var requires_foundation: bool = false
@export var load_bearing: bool = false
@export var weight: float = 1.0
