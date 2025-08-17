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
var spatial_hash: Dictionary = {}
