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
