class_name ConnectivityComponent extends Resource

@export var connected_rooms: Array[int] = []
@export var connection_type: Dungeon.ConnectionTypes = Dungeon.ConnectionTypes.CORRIDOR
@export var is_main_path: bool = false
@export var connection_strength: float = 1.0
