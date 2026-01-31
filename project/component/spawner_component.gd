class_name SpawnerComponent
extends Node2D

signal spawned
signal job_completed

@export var bullet : PackedScene

var _timer: Timer = Timer.new()
var _target

@onready var _delay: int = randi_range(1, 5)


func _ready() -> void:
	add_child(_timer)
	_timer.one_shot = true
	_timer.wait_time = _delay
	_timer.timeout.connect(_on_timer_timeout)


func spawn(target):
	_timer.start()
	_target = target


func _on_bullet_screen_exited() -> void:
	job_completed.emit()


func _on_timer_timeout() -> void:
	var bullet_instance: Bullet = bullet.instantiate()
	add_child(bullet_instance)
	bullet_instance.screen_exited.connect(_on_bullet_screen_exited)
	bullet_instance.set_target(_target)
	bullet_instance.initialize()
	spawned.emit()
