class_name LootComponent extends Resource
"""
Advanced loot system with rarity, level scaling, and dynamic rewards.
Critical for player progression and exploration motivation.
"""

@export_group("Loot Properties")
@export var loot_rarity: String = "common" # common, uncommon, rare, epic, legendary, artifact
@export var item_type: String = "consumable" # consumable, weapon, armor, key, quest, currency, material
@export var item_id: String = ""
@export var item_level: int = 1

@export_group("Quantity and Probability")
@export var base_quantity: int = 1
@export var quantity_variance: int = 0 # ±variance
@export var spawn_probability: float = 1.0
@export var rarity_roll_bonus: float = 0.0
@export var luck_affects_quantity: bool = true

@export_group("Level Scaling")
@export var scales_with_player_level: bool = false
@export var min_player_level: int = 0
@export var max_player_level: int = 100
@export var level_requirement: int = 0
@export var overleveled_penalty: bool = true

@export_group("Respawn Behavior")
@export var respawn_enabled: bool = false
@export var respawn_time: float = -1.0 # -1 = never respawns
@export var respawn_depletes: bool = false
@export var max_respawns: int = -1

@export_group("Visual Presentation")
@export var loot_glow: bool = true
@export var rarity_color_coding: bool = true
@export var floating_animation: bool = true
@export var discovery_effect: PackedScene
@export var pickup_effect: PackedScene
