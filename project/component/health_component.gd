class_name HealthComponent
extends Node

signal on_health_zero

var _health := 10


func hurt(damage = 1) -> void:
	_health -= damage
	print(_health)
	if _health <= 0:
		on_health_zero.emit()


func heal(amount: int) -> void:
	_health += amount
