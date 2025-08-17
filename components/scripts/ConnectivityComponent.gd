const ConnectionTypes = preload("res://scripts/enums/ConnectionTypes.gd")

class_name ConnectivityComponent extends Resource

@export var connected_rooms: Array[int] = []
@export var connection_type: ConnectionTypes.ConnectionType = ConnectionTypes.ConnectionType.CORRIDOR
@export var is_main_path: bool = false
@export var connection_strength: float = 1.0
