class_name SpawnerComponent
extends Node2D

signal spawned
signal hit
signal job_completed

@export var settings: SpawnerSettings
var _timer: Timer = Timer.new()
var _bullet: Bullet


func _ready() -> void:
	add_child(_timer)
	_timer.one_shot = true
	_timer.timeout.connect(_on_timer_timeout)

	if settings:
		initialize()


func initialize(new_settings: SpawnerSettings = null) -> void:
	if new_settings:
		settings = new_settings

	assert(settings, "settings must be defined")

	if settings.position != Vector2.ZERO:
		global_position = settings.position
	_timer.wait_time = settings.delay


func spawn():
	_timer.start()


func _on_bullet_screen_exited() -> void:
	job_completed.emit()


func _on_timer_timeout() -> void:
	_bullet = settings.bullet_scene.instantiate()
	get_tree().get_root().add_child(_bullet)
	_bullet.global_position = global_position
	_bullet.job_completed.connect(_on_bullet_screen_exited)
	_bullet.initialize(settings.is_ghost)
	_bullet.aim(settings.direction)
	_bullet.hit.connect(hit.emit)
	spawned.emit()


func _exit_tree() -> void:
	if _bullet:
		_bullet.queue_free()
