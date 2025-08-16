class_name Actor
extends CharacterBody3D

@export var id_prefix: String = "ACT"
@onready var bt_player: BTPlayer = $BTPlayer

var id: String

func _enter_tree() -> void:
	id = GameStateManager.request_id(id_prefix)
	register_id()

func register_id():
	GameStateManager.register_actor(id)

func _exit_tree() -> void:
	GameStateManager.deregister_actor(id)
