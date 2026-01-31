class_name HitboxComponent
extends Area2D

signal hit(body: Node2D)


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(area: Area2D) -> void:
	var hurtbox := Component.find(area, "Hurtbox")

	if hurtbox:
		hit.emit(hurtbox)
