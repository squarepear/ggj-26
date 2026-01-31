extends Control


func update_waves_label(waves: int) -> void:
	%NumberOfWavesLabel.text = "%d waves." % waves


func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")
