# ============================================================================
# MANUAL IMPORTS FIX - Add these imports to resolve scope issues
# ============================================================================

# ============================================================================
# COMPONENT FILES WITH MANUAL IMPORTS
# ============================================================================

# File: TerrainTile3DComponent.gd
# ----------------------------------------------------------------------------
# Add these imports at the top
const TerrainTypes = preload("res://scripts/enums/TerrainTypes.gd")

class_name TerrainTile3DComponent extends Resource

@export var tile_type: TerrainTypes.TerrainType = TerrainTypes.TerrainType.FLOOR
@export var is_passable: bool = true
@export var mesh_resource: Mesh
@export var material_override: Material
@export var movement_cost: float = 1.0
@export var blocks_light: bool = false
@export var height: float = 1.0
@export var scale_modifier: Vector3 = Vector3.ONE

# ============================================================================

# File: RoomBounds3DComponent.gd
# ----------------------------------------------------------------------------
# Add these imports at the top
const RoomTypes = preload("res://scripts/enums/RoomTypes.gd")

class_name RoomBounds3DComponent extends Resource

@export var bounds: AABB
@export var room_type: RoomTypes.RoomType = RoomTypes.RoomType.NORMAL
@export var theme: String = "default"
@export var min_connections: int = 1
@export var max_connections: int = 4
@export var is_generated: bool = false
@export var ceiling_height: float = 3.0
@export var floor_level: float = 0.0

# ============================================================================

# File: CorridorSegment3DComponent.gd
# ----------------------------------------------------------------------------
# Add these imports at the top
const CorridorTypes = preload("res://scripts/enums/CorridorTypes.gd")

class_name CorridorSegment3DComponent extends Resource

@export var start_pos: Vector3i
@export var end_pos: Vector3i
@export var width: int = 1
@export var height: float = 3.0
@export var corridor_type: CorridorTypes.CorridorType = CorridorTypes.CorridorType.STRAIGHT
@export var connects_rooms: Array[int] = []

# ============================================================================

# File: TerrainFeature3DComponent.gd
# ----------------------------------------------------------------------------
# Add these imports at the top
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

# ============================================================================

# File: SpawnPointComponent.gd
# ----------------------------------------------------------------------------
# Add these imports at the top
const SpawnTypes = preload("res://scripts/enums/SpawnTypes.gd")

class_name SpawnPointComponent extends Resource

@export var spawn_type: SpawnTypes.SpawnType
@export var entity_scene: PackedScene
@export var spawn_probability: float = 1.0
@export var max_spawns: int = 1
@export var respawn_time: float = -1.0
@export var spawn_conditions: Array[String] = []

# ============================================================================

# File: HazardZoneComponent.gd
# ----------------------------------------------------------------------------
# Add these imports at the top
const HazardTypes = preload("res://scripts/enums/HazardTypes.gd")

class_name HazardZoneComponent extends Resource

@export var hazard_type: HazardTypes.HazardType
@export var damage_amount: int = 0
@export var effect_scene: PackedScene
@export var trigger_area: Area2D
@export var activation_delay: float = 0.0
@export var duration: float = -1.0

# ============================================================================

# File: ConnectivityComponent.gd
# ----------------------------------------------------------------------------
# Add these imports at the top
const ConnectionTypes = preload("res://scripts/enums/ConnectionTypes.gd")

class_name ConnectivityComponent extends Resource

@export var connected_rooms: Array[int] = []
@export var connection_type: ConnectionTypes.ConnectionType = ConnectionTypes.ConnectionType.CORRIDOR
@export var is_main_path: bool = false
@export var connection_strength: float = 1.0

# ============================================================================

# File: BiomePropertiesComponent.gd
# ----------------------------------------------------------------------------
# Add these imports at the top
const BiomeTypes = preload("res://scripts/enums/BiomeTypes.gd")

class_name BiomePropertiesComponent extends Resource

@export var biome_type: BiomeTypes.BiomeType = BiomeTypes.BiomeType.STONE_DUNGEON
@export var lighting_color: Color = Color.WHITE
@export var ambient_sound: AudioStream
@export var particle_effect: PackedScene
@export var fog_density: float = 0.1
@export var temperature: float = 20.0

# ============================================================================
# SYSTEM FILES WITH MANUAL IMPORTS
# ============================================================================

# File: Terrain3DEntityManager.gd
# ----------------------------------------------------------------------------
# Add these imports at the top
const TerrainTypes = preload("res://scripts/enums/TerrainTypes.gd")
const RoomTypes = preload("res://scripts/enums/RoomTypes.gd")
const FeatureTypes = preload("res://scripts/enums/FeatureTypes.gd")
const SpawnTypes = preload("res://scripts/enums/SpawnTypes.gd")

class_name Terrain3DEntityManager extends Node3D

signal entity_created(entity_id: int)
signal entity_destroyed(entity_id: int)
signal component_added(entity_id: int, component_type: String)
signal component_removed(entity_id: int, component_type: String)

var entities: Dictionary = {}
var component_pools: Dictionary = {}
var next_entity_id: int = 0
var systems: Array[Node] = []
var spatial_hash: Dictionary = {} # For 3D spatial queries

# Rest of the class remains the same...

# ============================================================================

# File: Dungeon3DGenerationSystem.gd
# ----------------------------------------------------------------------------
# Add these imports at the top
const TerrainTypes = preload("res://scripts/enums/TerrainTypes.gd")
const RoomTypes = preload("res://scripts/enums/RoomTypes.gd")
const CorridorTypes = preload("res://scripts/enums/CorridorTypes.gd")
const FeatureTypes = preload("res://scripts/enums/FeatureTypes.gd")
const SpawnTypes = preload("res://scripts/enums/SpawnTypes.gd")

class_name Dungeon3DGenerationSystem extends Node3D

signal generation_progress(step: String, progress: float)
signal generation_completed(dungeon_data: Dictionary)
signal generation_failed(error_message: String)

@export var dungeon_mesh_root: Node3D
@export var navigation_region: NavigationRegion3D
@export var entity_manager: Terrain3DEntityManager

# Rest of the class with imports working properly...

func _determine_room_type(room_index: int) -> RoomTypes.RoomType:
	if room_index == 0:
		return RoomTypes.RoomType.ENTRANCE
	elif room_index == 1:
		return RoomTypes.RoomType.EXIT
	else:
		return RoomTypes.RoomType.NORMAL

func _place_3d_feature_in_room(room_bounds: AABB, rng: RandomNumberGenerator):
	var feature_pos = Vector3i(
		rng.randi_range(int(room_bounds.position.x + 1), int(room_bounds.end.x - 2)),
		rng.randi_range(int(room_bounds.position.y + 1), int(room_bounds.end.y - 2)),
		int(room_bounds.position.z)
	)
	
	var feature_entity = entity_manager.create_entity()
	var feature_component = TerrainFeature3DComponent.new()
	feature_component.position = feature_pos
	feature_component.feature_type = FeatureTypes.FeatureType.values()[rng.randi() % FeatureTypes.FeatureType.size()]
	
	entity_manager.add_component(feature_entity, feature_component)
	current_generation_data.features.append(feature_entity)

func _create_spawn_point(position: Vector2i, spawn_type: SpawnTypes.SpawnType):
	var spawn_entity = entity_manager.create_entity()
	var spawn_component = SpawnPointComponent.new()
	spawn_component.spawn_type = spawn_type
	
	var grid_component = GridPosition3DComponent.new()
	grid_component.grid_pos = Vector3i(position.x, position.y, 0)
	grid_component.update_world_pos()
	
	entity_manager.add_component(spawn_entity, spawn_component)
	entity_manager.add_component(spawn_entity, grid_component)
	current_generation_data.spawn_points.append(spawn_entity)

# ============================================================================

# File: Dungeon3DMeshBuilder.gd
# ----------------------------------------------------------------------------
# Add these imports at the top
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

# ============================================================================

# File: Dungeon3DDebugger.gd
# ----------------------------------------------------------------------------
# Add these imports at the top
const RoomTypes = preload("res://scripts/enums/RoomTypes.gd")
const FeatureTypes = preload("res://scripts/enums/FeatureTypes.gd")

class_name Dungeon3DDebugger extends Node3D

var entity_manager: Terrain3DEntityManager
var debug_draw_enabled: bool = true
var debug_materials: Dictionary = {}

func _get_room_color(room_type: RoomTypes.RoomType) -> Color:
	match room_type:
		RoomTypes.RoomType.ENTRANCE:
			return Color.GREEN
		RoomTypes.RoomType.EXIT:
			return Color.RED
		RoomTypes.RoomType.BOSS:
			return Color.PURPLE
		RoomTypes.RoomType.TREASURE:
			return Color.GOLD
		RoomTypes.RoomType.SECRET:
			return Color.CYAN
		_:
			return Color.WHITE

func _get_feature_color(feature_type: FeatureTypes.FeatureType) -> Color:
	match feature_type:
		FeatureTypes.FeatureType.CHEST:
			return Color.GOLD
		FeatureTypes.FeatureType.TORCH:
			return Color.ORANGE
		FeatureTypes.FeatureType.WATER:
			return Color.BLUE
		FeatureTypes.FeatureType.PIT:
			return Color.BLACK
		FeatureTypes.FeatureType.TRAP:
			return Color.RED
		_:
			return Color.GRAY

# ============================================================================
# IMPORT REFERENCE GUIDE
# ============================================================================

"""
IMPORT CHEAT SHEET:

For any file that uses enums, add these imports at the top:

// Basic Enums (most common)
const TerrainTypes = preload("res://scripts/enums/TerrainTypes.gd")
const RoomTypes = preload("res://scripts/enums/RoomTypes.gd")
const FeatureTypes = preload("res://scripts/enums/FeatureTypes.gd")
const SpawnTypes = preload("res://scripts/enums/SpawnTypes.gd")

// Extended Enums (as needed)
const CorridorTypes = preload("res://scripts/enums/CorridorTypes.gd")
const BiomeTypes = preload("res://scripts/enums/BiomeTypes.gd")
const HazardTypes = preload("res://scripts/enums/HazardTypes.gd")
const ConnectionTypes = preload("res://scripts/enums/ConnectionTypes.gd")

IMPORT RULES:

1. Add imports BEFORE class_name declaration
2. Only import what you actually use in that file
3. Use the exact path to your enum files
4. Adjust paths if your folder structure is different

EXAMPLE FILE STRUCTURE:
res://
├── scripts/
│   ├── enums/           ← Your enum files go here
│   ├── components/      ← Your component files go here  
│   └── systems/         ← Your system files go here

PATH EXAMPLES:
- If enums are in res://enums/: preload("res://enums/TerrainTypes.gd")
- If enums are in res://scripts/: preload("res://scripts/TerrainTypes.gd")
- Current structure: preload("res://scripts/enums/TerrainTypes.gd")
"""
