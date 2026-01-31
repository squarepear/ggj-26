class_name Bullet
extends CharacterBody2D

signal job_completed

const GHOST_COLLISION_LAYER := 8

@onready var _movement_compenent: MovementCompenent = $MovementCompenent
@onready var _target_component: TargetComponent = $TargetComponent
@onready var _hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var _visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier

@export var size := 1

func initialize(is_ghost := false) -> void:
	_movement_compenent.set_dir(_target_component.get_target_direction())
	_movement_compenent.update()
	_visible_on_screen_notifier.screen_exited.connect(_on_visible_on_screen_notifier_screen_exited)
	scale = Vector2(size,size)
	
	if is_ghost:
		_hurtbox_component.collision_layer = GHOST_COLLISION_LAYER


func _physics_process(delta: float) -> void:
	_movement_compenent.update()


func set_target(target) -> void:
	_target_component.set_target(target)


func _on_visible_on_screen_notifier_screen_exited() -> void:
	job_completed.emit()
	queue_free()
