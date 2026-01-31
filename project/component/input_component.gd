class_name InputComponent
extends Node

var dir: Vector2


func apply_inputs() -> void:
	dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
