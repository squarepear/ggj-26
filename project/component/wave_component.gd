class_name WaveComponent
extends Node

signal wave_completed

var _spawners_completed := 0
var _hits: Array[SpawnerSettings]


func add_spawner(settings: SpawnerSettings) -> void:
	var spawner := SpawnerComponent.new()
	add_child(spawner)
	spawner.initialize(settings)
	spawner.hit.connect(_on_spawner_hit.bind(spawner.settings))
	spawner.job_completed.connect(_increment_spawners_completed)


func start():
	_hits = []
	for child in get_children():
		child.spawn()


func get_hits() -> Array[SpawnerSettings]:
	return _hits


func _increment_spawners_completed() -> void:
	_spawners_completed += 1

	if _spawners_completed >= get_child_count():
		_complete_wave()


func _complete_wave() -> void:
	_spawners_completed = 0
	wave_completed.emit()


func _on_spawner_hit(settings: SpawnerSettings) -> void:
	_hits.append(settings)
