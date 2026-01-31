class_name WaveGenerator
extends Node

const BOUNDARY_OFFSET := 64.0

@export var _bullet_scenes: Array[PackedScene] = []
@export var _wave_component: WaveComponent


func _ready() -> void:
	assert(_wave_component, "target wave component must be assigned!")

	for i in 5:
		print(_get_random_spawn_point())
		var spawner := SpawnerComponent.new()
		_wave_component.add_child(spawner)
		spawner.global_position = _get_random_spawn_point()
		spawner.bullet = _bullet_scenes[0]


# Gets a random point along the boundary of the screen with an offset of BOUNDARY_OFFSET
func _get_random_spawn_point() -> Vector2:
	var boundary := get_viewport().get_visible_rect()
	boundary.position -= Vector2.ONE * BOUNDARY_OFFSET
	boundary.size += Vector2.ONE * BOUNDARY_OFFSET * 2

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
