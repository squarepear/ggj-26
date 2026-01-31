class_name WaveComponent
extends Node

@export var target : CharacterBody2D

func add_spawner(position: Vector2, bullet_scene: PackedScene) -> void:
	var spawner := SpawnerComponent.new()
	add_child(spawner)
	spawner.global_position = position
	spawner.bullet = bullet_scene

func start_wave():
	for child in get_children():
		child.spawn(target)
