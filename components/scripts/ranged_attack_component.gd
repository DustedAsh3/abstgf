class_name RangedAttackComponent
extends BaseComponent

@export var projectile : Projectile
var projectile_cooldown
var can_fire
var targets
var animation_player : AnimationPlayer = null
var has_animation := false
