class_name WaveComponent
extends Node

signal wave_completed

@export var target : CharacterBody2D

var _spawners_completed := 0


func add_spawner(position: Vector2, bullet_scene: PackedScene) -> void:
	var spawner := SpawnerComponent.new()
	add_child(spawner)
	spawner.global_position = position
	spawner.bullet = bullet_scene
	spawner.job_completed.connect(_increment_spawners_completed)


func start():
	for child in get_children():
		child.spawn(target)


func _increment_spawners_completed() -> void:
	_spawners_completed += 1

	if _spawners_completed >= get_child_count():
		_complete_wave()


func _complete_wave() -> void:
	_spawners_completed = 0
	wave_completed.emit()
