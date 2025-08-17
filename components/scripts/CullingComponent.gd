class_name CullingComponent extends Resource
"""
Advanced culling system for hiding invisible geometry.
Critical for performance in complex dungeons.
"""

@export_group("Culling Types")
@export var use_frustum_culling: bool = true
@export var use_occlusion_culling: bool = true
@export var use_distance_culling: bool = true
@export var use_layer_culling: bool = false

@export_group("Frustum Culling")
@export var bounding_box: AABB
@export var bounding_sphere_radius: float = 0.0
@export var custom_bounds: bool = false
@export var bounds_padding: float = 0.0

@export_group("Distance Culling")
@export var max_draw_distance: float = 100.0
@export var min_draw_distance: float = 0.1
@export var distance_fade_range: float = 10.0
@export var use_squared_distance: bool = true

@export_group("Occlusion Culling")
@export var occlusion_enabled: bool = true
@export var occluder_shape: Shape3D
@export var blocks_others: bool = true
@export var can_be_occluded: bool = true

@export_group("Special Cases")
@export var always_visible: bool = false
@export var never_cull: bool = false
@export var cull_when_not_moving: bool = false
@export var player_proximity_override: float = 5.0
