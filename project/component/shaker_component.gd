class_name ShakerComponent
extends Node2D


func shake() -> void:
	var mult := 1 if randf() > 0.5 else -1
	var tween := get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees", 15 * mult, 0.08)
	tween.tween_property(self, "rotation_degrees", -15 * mult, 0.08)
	tween.tween_property(self, "rotation_degrees", 0, 0.1)


func lean(angle: int) -> void:
	rotation_degrees = angle
