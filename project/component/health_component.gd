class_name HealthComponent
extends Node

signal on_health_zero

var _health := 10


func hurt(damage: int) -> void:
	_health -= damage
	if _health <= 0:
		on_health_zero.emit()


func heal(amount: int) -> void:
	_health += amount
