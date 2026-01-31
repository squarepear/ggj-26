class_name SpawnerComponent
extends Node2D

@export var bullet : PackedScene


func spawn(target):
	var bullet_instance = bullet.instantiate()
	add_child(bullet_instance)
	bullet_instance.set_target(target)
	bullet_instance.initialize()
	
