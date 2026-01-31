class_name Bullet
extends CharacterBody2D

signal hit
signal job_completed

const GHOST_COLLISION_LAYER := 8

@export var size := 1

var _is_ghost := false
var _offscreen_timer: SceneTreeTimer

@onready var _icon: Sprite2D = $Icon
@onready var _movement_compenent: MovementCompenent = $MovementCompenent
@onready var _hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var _visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier


func initialize(is_ghost := false) -> void:
	_visible_on_screen_notifier.screen_exited.connect(_on_visible_on_screen_notifier_screen_exited)
	scale = Vector2(size,size)
	_hurtbox_component.hit.connect(hit.emit.unbind(1))
	
	_is_ghost = is_ghost
	if is_ghost:
		_icon.hide()
		_hurtbox_component.collision_layer = GHOST_COLLISION_LAYER


func _physics_process(delta: float) -> void:
	_movement_compenent.update()

	if not _offscreen_timer and not _visible_on_screen_notifier.is_on_screen():
		_offscreen_timer = get_tree().create_timer(3.0)
		_offscreen_timer.timeout.connect(_check_offscreen)


func aim(direction: Vector2) -> void:
	_movement_compenent.set_dir(direction)


func _check_offscreen() -> void:
	if _visible_on_screen_notifier.is_on_screen():
		_offscreen_timer = null
		return

	_on_visible_on_screen_notifier_screen_exited()
	

func _on_visible_on_screen_notifier_screen_exited() -> void:
	job_completed.emit()
	queue_free()
