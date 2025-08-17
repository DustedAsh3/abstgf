const TerrainTypes = preload("res://scripts/enums/TerrainTypes.gd")
const FeatureTypes = preload("res://scripts/enums/FeatureTypes.gd")

class_name Dungeon3DMeshBuilder extends Node3D

@export var default_materials: Dictionary = {}
@export var mesh_library: Dictionary = {}
@export var entity_manager: Terrain3DEntityManager
@export var tile_size: float = 2.0

var surface_tool: SurfaceTool
var mesh_instances: Dictionary = {}

func _setup_default_materials():
	# Create basic materials for different terrain types
	var wall_material = StandardMaterial3D.new()
	wall_material.albedo_color = Color.GRAY
	wall_material.roughness = 0.8
	default_materials[TerrainTypes.TerrainType.WALL] = wall_material
	
	var floor_material = StandardMaterial3D.new()
	floor_material.albedo_color = Color.WHITE
	floor_material.roughness = 0.6
	default_materials[TerrainTypes.TerrainType.FLOOR] = floor_material
	
	var water_material = StandardMaterial3D.new()
	water_material.albedo_color = Color.BLUE
	water_material.roughness = 0.1
	water_material.metallic = 0.0
	default_materials[TerrainTypes.TerrainType.WATER] = water_material

func _setup_mesh_library():
	# Create basic primitive meshes
	mesh_library[TerrainTypes.TerrainType.WALL] = _create_wall_mesh()
	mesh_library[TerrainTypes.TerrainType.FLOOR] = _create_floor_mesh()
	mesh_library[TerrainTypes.TerrainType.CEILING] = _create_ceiling_mesh()
	mesh_library[TerrainTypes.TerrainType.WATER] = _create_water_mesh()

func _build_feature_geometry(feature_component: TerrainFeature3DComponent, parent_node: Node3D):
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.position = Vector3(feature_component.position) * tile_size
	mesh_instance.rotation = feature_component.rotation
	
	# Set mesh based on feature type
	match feature_component.feature_type:
		FeatureTypes.FeatureType.PILLAR:
			mesh_instance.mesh = _create_pillar_mesh()
		FeatureTypes.FeatureType.CHEST:
			mesh_instance.mesh = _create_chest_mesh()
		FeatureTypes.FeatureType.TORCH:
			mesh_instance.mesh = _create_torch_mesh()
		_:
			mesh_instance.mesh = BoxMesh.new()
	
	parent_node.add_child(mesh_instance)
	mesh_instances[feature_component.position] = mesh_instance

func _get_tile_type_for_feature(feature_type: FeatureTypes.FeatureType) -> TerrainTypes.TerrainType:
	match feature_type:
		FeatureTypes.FeatureType.WATER:
			return TerrainTypes.TerrainType.WATER
		FeatureTypes.FeatureType.PIT:
			return TerrainTypes.TerrainType.PIT
		_:
			return TerrainTypes.TerrainType.FLOOR

func _place_tile_at_position(pos: Vector3i, tile_type: TerrainTypes.TerrainType, parent_node: Node3D):
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.position = Vector3(pos) * tile_size
	mesh_instance.mesh = mesh_library.get(tile_type, BoxMesh.new())
	mesh_instance.material_override = default_materials.get(tile_type)
	
	# Add collision
	var static_body = StaticBody3D.new()
	var collision_shape = CollisionShape3D.new()
	collision_shape.shape = mesh_instance.mesh.create_trimesh_shape()
	static_body.add_child(collision_shape)
	mesh_instance.add_child(static_body)
	
	parent_node.add_child(mesh_instance)
	mesh_instances[pos] = mesh_instance
