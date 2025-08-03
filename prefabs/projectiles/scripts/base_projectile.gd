class_name Projectile
extends StaticBody3D

var direction := Vector3.FORWARD
@export var speed := 10.0
@export var lifespan := 10.0
@export var event_entity_hit := "event_entity_hit"
var _time_alive := 0.0
@export var data := {
	"damage" : 2.0,
	"damage_type" : "normal"
}

func set_direction(dir: Vector3) -> void:
	direction = dir.normalized()
	look_at(global_transform.origin + direction, Vector3.UP)

func _physics_process(delta: float) -> void:
	_time_alive += delta
	if _time_alive >= lifespan:
		queue_free()
		return

	var motion: Vector3 = direction * speed * delta
	var collision = move_and_collide(motion)
	if collision:
		_on_hit(collision)

func _on_hit(collision: KinematicCollision3D): #This is unstable.
	EventBus.emit_event(event_entity_hit, collision.get_collider_id(), data)
	self.queue_free()
	
