extends Node

#Enums
#TerrainTypes
#RoomTypes
#CorridorTypes
#FeatureTypes
#BiomeTypes
#SpawnTypes
#HazardTypes
#ConnectionTypes

enum TerrainTypes {
	TOWN,
	DESERT,
	DUNGEON
}

enum RoomTypes {
	ENTRANCE,
	EXIT,
	BATTLE_1
}

enum CorridorTypes {
	HALL,
	T_SECTION,
	DEAD_END
}

enum FeatureTypes {
	HILL,
	COVER,
	PIT
}

enum BiomeTypes {
	DESERT,
	CAVERN,
	DUNGEON
}

enum SpawnTypes {
	CLUSTER,
	WAVE,
	SINGLE
}

enum HazardTypes {
	SPIKES,
	SANDSTORM,
	LAVA
}

enum ConnectionTypes {
	CORRIDOR,
	ROOM
}
