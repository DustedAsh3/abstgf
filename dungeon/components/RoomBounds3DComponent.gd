class_name RoomBounds3DComponent extends Resource

@export var bounds: AABB
@export var room_type: Dungeon.RoomTypes = Dungeon.RoomTypes.ENTRANCE
@export var theme: String = "default"
@export var min_connections: int = 1
@export var max_connections: int = 4
@export var is_generated: bool = false
@export var ceiling_height: float = 3.0
@export var floor_level: float = 0.0
