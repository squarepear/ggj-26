class_name MovementCompenent
extends Node

@export var _body: CharacterBody2D
@export var speed := 512.0

var _dir := Vector2.ZERO



func set_dir(new_dir: Vector2) -> void:
	_dir = new_dir


func update() -> void:
	_body.velocity = _dir * speed
	_body.move_and_slide()


func set_speed(new_speed: float) -> void:
	speed = new_speed
