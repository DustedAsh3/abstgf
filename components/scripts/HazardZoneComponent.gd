const HazardTypes = preload("res://scripts/enums/HazardTypes.gd")

class_name HazardZoneComponent extends Resource

@export var hazard_type: HazardTypes.HazardType
@export var damage_amount: int = 0
@export var effect_scene: PackedScene
@export var trigger_area: Area2D
@export var activation_delay: float = 0.0
@export var duration: float = -1.0extends Node
