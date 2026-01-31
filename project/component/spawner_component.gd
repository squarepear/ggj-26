class_name SpawnerComponent
extends Node

@export var bullet : PackedScene

func spawn():
	var bullet_instance = bullet.instantiate()
	add_child(bullet_instance)
