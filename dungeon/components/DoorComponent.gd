class_name DoorComponent extends Resource
"""
Handles all types of doors, gates, and barriers in the dungeon.
Essential for creating meaningful room connections and progression gates.
"""

@export_group("Door Properties")
@export var door_type: String = "wooden" # wooden, iron, magical, secret, portcullis
@export var door_state: String = "closed" # closed, open, locked, broken, jammed
@export var is_locked: bool = false
@export var required_key_id: String = ""
@export var lock_difficulty: int = 1 # For lockpicking mechanics

@export_group("Physical Properties")
@export var health: int = 100
@export var armor: int = 0
@export var can_be_destroyed: bool = true
@export var can_be_lockpicked: bool = true
@export var can_be_forced: bool = true
@export var force_difficulty: int = 5

@export_group("Animation and Visual")
@export var open_animation: String = "swing" # swing, slide, fade, crumble
@export var animation_duration: float = 1.0
@export var door_mesh_closed: Mesh
@export var door_mesh_open: Mesh
@export var door_material: Material

@export_group("Audio")
@export var open_sound: AudioStream
@export var close_sound: AudioStream
@export var locked_sound: AudioStream
@export var break_sound: AudioStream

@export_group("Interaction")
@export var auto_close: bool = false
@export var auto_close_delay: float = 3.0
@export var requires_switch: bool = false
@export var linked_switch_id: String = ""
