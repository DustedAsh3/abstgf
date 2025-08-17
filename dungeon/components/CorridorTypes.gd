class_name CorridorSegment3DComponent extends Resource

@export var start_pos: Vector3i
@export var end_pos: Vector3i
@export var width: int = 1
@export var height: float = 3.0
@export var corridor_type: Dungeon.CorridorTypes = Dungeon.CorridorTypes.HALL
@export var connects_rooms: Array[int] = []
