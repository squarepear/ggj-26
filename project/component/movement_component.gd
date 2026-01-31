class_name MovementCompenent
extends Node

@export var _body: CharacterBody2D

var _dir := Vector2.ZERO
var _speed := 256.0


func set_dir(new_dir: Vector2) -> void:
	_dir = new_dir


func update() -> void:
	_body.velocity = _dir * _speed
	_body.move_and_slide()
