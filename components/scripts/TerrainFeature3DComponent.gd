const FeatureTypes = preload("res://scripts/enums/FeatureTypes.gd")

class_name TerrainFeature3DComponent extends Resource

@export var feature_type: FeatureTypes.FeatureType
@export var position: Vector3i
@export var size: Vector3i = Vector3i.ONE
@export var rotation: Vector3 = Vector3.ZERO
@export var is_interactive: bool = false
@export var interaction_scene: PackedScene
@export var mesh_resource: Mesh
@export var collision_shape: Shape3D
