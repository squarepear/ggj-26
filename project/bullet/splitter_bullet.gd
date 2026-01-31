extends Bullet

@onready var _spawner_component: SpawnerComponent = $SpawnerComponent

var screen_exited := false
var job_done := false


func aim(direction: Vector2) -> void:
	super(direction)
	_spawner_component._settings.direction = -_movement_compenent._dir


func _physics_process(_delta: float) -> void:
	super(_delta)
	if screen_exited and job_done:
		job_completed.emit()
		queue_free()


func _on_timer_timeout() -> void:
	if not _visible_on_screen_notifier.is_on_screen():
		job_done = true
		return

	_spawner_component.spawn()
	

func _on_visible_on_screen_notifier_screen_exited() -> void:
	screen_exited = true


func _on_spawner_component_job_completed() -> void:
	job_done = true
