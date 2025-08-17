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
