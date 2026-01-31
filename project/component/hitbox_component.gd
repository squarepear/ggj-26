class_name HitboxComponent
extends Area2D

signal hit(hurtbox: HurtboxComponent)


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		area.on_hitbox_entered(self)
		hit.emit(area)
		print("YEOUCH!")
