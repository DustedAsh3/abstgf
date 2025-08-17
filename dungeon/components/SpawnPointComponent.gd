class_name SpawnPointComponent extends Resource

@export var spawn_type: Dungeon.SpawnTypes
@export var entity_scene: PackedScene
@export var spawn_probability: float = 1.0
@export var max_spawns: int = 1
@export var respawn_time: float = -1.0
@export var spawn_conditions: Array[String] = []
