extends CharacterBody2D

@onready var _movement_compenent: MovementCompenent = $MovementCompenent
@onready var _target_component: TargetComponent = $TargetComponent


func initialize():
	_movement_compenent.set_dir(_target_component.get_target_direction())
	_movement_compenent.update()

func _physics_process(delta: float) -> void:
	_movement_compenent.update()

func set_target(target):
	_target_component.set_target(target)
