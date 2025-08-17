class_name CorridorStyleComponent extends Resource
"""
Advanced corridor generation with architectural variety and purpose.
Transforms boring hallways into interesting architectural elements.
"""

@export_group("Style Definition")
@export var style_name: String = ""
@export var style_type: String = "straight" # straight, curved, zigzag, spiral, branched
@export var architectural_period: String = "medieval" # medieval, modern, ancient, futuristic

@export_group("Dimensional Properties")
@export var base_width: int = 1
@export var width_variation: bool = false
@export var width_variance: int = 0
@export var height_variation: bool = false
@export var height_variance: float = 0.0

@export_group("Architectural Elements")
@export var has_alcoves: bool = false
@export var alcove_frequency: float = 0.2
@export var alcove_depth: int = 1
@export var has_pillars: bool = false
@export var pillar_spacing: int = 4

@export_group("Decorative Features")
@export var decorative_elements: Array[String] = [] # tapestries, murals, statues
@export var decoration_frequency: float = 0.3
@export var wall_trim: bool = false
@export var floor_patterns: bool = false

@export_group("Lighting Design")
@export var lighting_pattern: String = "regular" # regular, sparse, dramatic, alternating
@export var light_spacing: float = 4.0
@export var uses_wall_sconces: bool = true
@export var uses_ceiling_lights: bool = false

@export_group("Functional Elements")
@export var has_side_passages: bool = false
@export var side_passage_frequency: float = 0.1
@export var has_dead_ends: bool = false
@export var includes_shortcuts: bool = false
