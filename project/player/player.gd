extends CharacterBody2D

signal killed

@onready var _input_component: InputComponent = $InputComponent
@onready var _movement_compenent: MovementCompenent = $MovementCompenent
@onready var _hitbox_component: HitboxComponent = $HitboxComponent
@onready var _vision_blocker: VisionBlocker = $VisionBlocker
@onready var _shaker_component: ShakerComponent = $ShakerComponent



var can_move := true

func _ready():
	%Head.play("default")
	_hitbox_component.hit.connect(_vision_blocker.splat.unbind(1))
	_hitbox_component.hit.connect(_shaker_component.shake.unbind(1))


func _physics_process(_delta: float) -> void:
	if can_move:
		_input_component.apply_inputs()
		_movement_compenent.set_dir(_input_component.dir)
		_movement_compenent.update()
		_shaker_component.lean(_input_component.dir.x * 10)



func _blink():
	var random_int: int = randi_range(0,1)
	if random_int == 0:
		%Head.play("blink1")
	else:
		%Head.play("blink2")


func _on_blink_timer_timeout() -> void:
	_blink()


func _on_vision_blocker_fully_splotted() -> void:
	can_move = false
	killed.emit()
