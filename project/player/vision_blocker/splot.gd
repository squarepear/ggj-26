class_name Splot
extends Sprite2D


func _ready() -> void:
	scale = Vector2.ZERO


func splat() -> void:
	%AnimationPlayer.play("splat")
