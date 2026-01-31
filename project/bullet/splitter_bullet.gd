extends Bullet

@onready var _spawner_component: SpawnerComponent = $SpawnerComponent

var screen_exited := false
var job_done := false


func _physics_process(_delta: float) -> void:
	super(_delta)
	if screen_exited and job_done:
		job_completed.emit()
		queue_free()


func _on_timer_timeout() -> void:
	_spawner_component.spawn(_target_component.get_target())
	

func _on_visible_on_screen_notifier_screen_exited() -> void:
	screen_exited = true


func _on_spawner_component_job_completed() -> void:
	job_done = true
