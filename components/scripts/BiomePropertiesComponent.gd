const BiomeTypes = preload("res://scripts/enums/BiomeTypes.gd")

class_name BiomePropertiesComponent extends Resource

@export var biome_type: BiomeTypes.BiomeType = BiomeTypes.BiomeType.STONE_DUNGEON
@export var lighting_color: Color = Color.WHITE
@export var ambient_sound: AudioStream
@export var particle_effect: PackedScene
@export var fog_density: float = 0.1
@export var temperature: float = 20.0
