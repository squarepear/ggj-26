extends CharacterBody2D

@onready var _movement_compenent: MovementCompenent = $MovementCompenent
@onready var _target_component: TargetComponent = $TargetComponent


func _ready() -> void:
	_movement_compenent.set_dir(_target_component.get_target_direction())
	_movement_compenent.update()
