extends CharacterBody2D

@onready var _input_component: InputComponent = $InputComponent
@onready var _movement_compenent: MovementCompenent = $MovementCompenent
@onready var health_component: HealthComponent = $HealthComponent



func _ready():
	%Head.play("default")


func _physics_process(_delta: float) -> void:
	_input_component.apply_inputs()

	_movement_compenent.set_dir(_input_component.dir)
	_movement_compenent.update()


func _on_hitbox_component_hit(hurtbox: HurtboxComponent) -> void:
	health_component.hurt()


func _blink():
	var random_int: int = randi_range(0,1)
	if random_int == 0:
		%Head.play("blink1")
	else:
		%Head.play("blink2")


func _on_blink_timer_timeout() -> void:
	_blink()
