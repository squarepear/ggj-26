extends Control


func _on_timer_timeout() -> void:
	%VisionBlocker.splat()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")
