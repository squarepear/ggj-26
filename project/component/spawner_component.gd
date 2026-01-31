class_name SpawnerComponent
extends Node2D

signal spawned
signal job_completed

@export var bullet : PackedScene


func spawn(target):
	var bullet_instance: Bullet = bullet.instantiate()
	add_child(bullet_instance)
	bullet_instance.screen_exited.connect(_on_bullet_screen_exited)
	bullet_instance.set_target(target)
	bullet_instance.initialize()
	spawned.emit()


func _on_bullet_screen_exited() -> void:
	job_completed.emit()
