class_name WaveGenerator
extends Node

const BOUNDARY_OFFSET := 64.0

var _current_wave: int = 0

@export var _bullet_scenes: Array[PackedScene] = []
@export var _wave_component: WaveComponent
@export var _ghost_wave_component: WaveComponent


func _ready() -> void:
	assert(_wave_component, "target wave component must be assigned!")
	assert(_ghost_wave_component, "ghost wave component must be assigned!")


func generate() -> void:
	for child in _ghost_wave_component.get_children():
		_ghost_wave_component.remove_child(child)
		child.queue_free()

	_current_wave += 1
	var successful_settings := _ghost_wave_component.get_hits()
	successful_settings.shuffle()
	for i in 5:
		var settings: SpawnerSettings
		if i < successful_settings.size():
			settings = successful_settings[i]
		else:
			settings = _create_settings(_get_random_spawn_point())

		settings.is_ghost = false
		_wave_component.add_spawner(settings)

	for i in 100:
		_ghost_wave_component.add_spawner(_create_settings(_get_random_spawn_point()))

	_wave_component.start()
	_ghost_wave_component.start()


# Gets a random point along the boundary of the screen with an offset of BOUNDARY_OFFSET
func _get_random_spawn_point(offset := BOUNDARY_OFFSET) -> Vector2:
	var boundary := get_viewport().get_visible_rect()
	boundary.position -= Vector2.ONE * offset
	boundary.size += Vector2.ONE * offset * 2

	var pos := randf_range(0, boundary.size.x * 2 + boundary.size.y * 2)

	if pos < boundary.size.x:
		return boundary.position + Vector2.RIGHT * pos
	pos -= boundary.size.x

	if pos < boundary.size.x:
		return boundary.position + Vector2.DOWN * boundary.size.y + Vector2.RIGHT * pos
	pos -= boundary.size.x

	if pos < boundary.size.y:
		return boundary.position + Vector2.DOWN * pos
	pos -= boundary.size.y

	return boundary.position + Vector2.DOWN * pos + Vector2.RIGHT * boundary.size.x


func _create_settings(position: Vector2) -> SpawnerSettings:
	var settings := SpawnerSettings.new()
	settings.bullet_scene = _bullet_scenes.pick_random()
	settings.position = position
	settings.direction = (_get_random_spawn_point(-BOUNDARY_OFFSET) - position).normalized()
	settings.delay = randf_range(1, 5)
	settings.is_ghost = true

	return settings


func get_current_wave() -> int:
	return _current_wave
