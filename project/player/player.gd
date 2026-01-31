extends CharacterBody2D

@onready var _input_component: InputComponent = $InputComponent
@onready var _movement_compenent: MovementCompenent = $MovementCompenent
@onready var health_component: HealthComponent = $HealthComponent


func _physics_process(_delta: float) -> void:
	_input_component.apply_inputs()

	_movement_compenent.set_dir(_input_component.dir)
	_movement_compenent.update()



func _on_hitbox_component_hit(hurtbox: HurtboxComponent) -> void:
	health_component.hurt()
