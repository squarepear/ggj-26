class_name Bullet
extends CharacterBody2D

signal screen_exited

@onready var _movement_compenent: MovementCompenent = $MovementCompenent
@onready var _target_component: TargetComponent = $TargetComponent


func initialize():
	_movement_compenent.set_dir(_target_component.get_target_direction())
	_movement_compenent.update()


func _physics_process(delta: float) -> void:
	_movement_compenent.update()


func set_target(target) -> void:
	_target_component.set_target(target)


func _on_visible_on_screen_notifier_screen_exited() -> void:
	screen_exited.emit()
