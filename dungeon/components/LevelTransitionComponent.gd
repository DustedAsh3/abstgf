class_name LevelTransitionComponent extends Resource
"""
Manages transitions between different levels of the dungeon.
Critical for multi-level dungeons and vertical progression.
"""

@export_group("Transition Properties")
@export var transition_type: String = "stairs" # stairs, elevator, portal, ladder, teleporter, pit
@export var direction: String = "down" # up, down, horizontal, bidirectional
@export var target_level: int = 0
@export var target_position: Vector3 = Vector3.ZERO
@export var target_scene_path: String = ""

@export_group("Access Control")
@export var is_entrance: bool = false
@export var is_exit: bool = false
@export var requires_key: bool = false
@export var required_key_id: String = ""
@export var requires_quest_completion: bool = false
@export var required_quest_id: String = ""

@export_group("Visual and Animation")
@export var transition_mesh: Mesh
@export var transition_material: Material
@export var particle_effect: PackedScene
@export var transition_animation: String = "fade" # fade, spiral, beam, portal

@export_group("Audio")
@export var activation_sound: AudioStream
@export var ambient_sound: AudioStream
@export var transition_sound: AudioStream
