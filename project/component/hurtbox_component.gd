class_name HurtboxComponent
extends Area2D

signal hit(hitbox: HitboxComponent)


func on_hitbox_entered(hitbox: HitboxComponent) -> void:
	hit.emit(hitbox)
