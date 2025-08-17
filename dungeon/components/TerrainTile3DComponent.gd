class_name TerrainTile3DComponent extends Resource

@export var tile_type: TerrainTypes.TerrainType = Dungeon.TerrainTypes.FLOOR
@export var is_passable: bool = true
@export var mesh_resource: Mesh
@export var material_override: Material
@export var movement_cost: float = 1.0
@export var blocks_light: bool = false
@export var height: float = 1.0
@export var scale_modifier: Vector3 = Vector3.ONE
