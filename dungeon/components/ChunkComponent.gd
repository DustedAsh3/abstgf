class_name ChunkComponent extends Resource
"""
Chunk-based loading system for massive dungeons.
Enables virtually unlimited dungeon size.
"""

@export_group("Chunk Properties")
@export var chunk_coordinates: Vector3i
@export var chunk_size: Vector3i = Vector3i(16, 16, 16)
@export var chunk_type: String = "standard" # standard, special, boss, transition

@export_group("Loading State")
@export var is_loaded: bool = false
@export var is_active: bool = false
@export var is_visible: bool = false
@export var load_priority: int = 0
@export var unload_delay: float = 30.0

@export_group("Content Management")
@export var entities_in_chunk: Array[int] = []
@export var static_meshes: Array[MeshInstance3D] = []
@export var dynamic_objects: Array[Node3D] = []
@export var light_sources: Array[Light3D] = []

@export_group("Neighbor Management")
@export var neighbor_chunks: Array[Vector3i] = []
@export var required_neighbors: Array[Vector3i] = []
@export var load_with_neighbors: bool = true
@export var neighbor_load_distance: int = 1

@export_group("Memory Management")
@export var memory_budget: int = 64 # MB
@export var texture_streaming: bool = true
@export var mesh_compression: bool = true
@export var audio_streaming: bool = true
