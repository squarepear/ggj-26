class_name SpawnerComponent
extends Node2D

signal spawned
signal job_completed

@export var _settings: SpawnerSettings
var _timer: Timer = Timer.new()


func _ready() -> void:
	add_child(_timer)
	_timer.one_shot = true
	_timer.timeout.connect(_on_timer_timeout)

	if _settings:
		initialize()


func initialize(settings: SpawnerSettings = null) -> void:
	if settings:
		_settings = settings

	assert(_settings, "settings must be defined")

	if _settings.position != Vector2.ZERO:
		global_position = _settings.position
	_timer.wait_time = _settings.delay


func spawn():
	_timer.start()


func _on_bullet_screen_exited() -> void:
	job_completed.emit()


func _on_timer_timeout() -> void:
	var bullet_instance: Bullet = _settings.bullet_scene.instantiate()
	get_tree().get_root().add_child(bullet_instance)
	bullet_instance.global_position = global_position
	bullet_instance.job_completed.connect(_on_bullet_screen_exited)
	bullet_instance.initialize(_settings.is_ghost)
	bullet_instance.aim(_settings.direction)
	spawned.emit()
