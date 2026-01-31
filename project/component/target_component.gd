class_name TargetComponent
extends Node

@export var _body: CharacterBody2D
var _target: CharacterBody2D


func set_target(target) -> void:
	_target = target

func get_target() -> CharacterBody2D:
	return _target

func get_target_direction() -> Vector2:
	assert(_target != null, "Bullet does not have a target.")
	return (_target.global_position - _body.global_position).normalized()
