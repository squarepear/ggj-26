extends Node2D

@onready var _wave_component: WaveComponent = %WaveComponent
@onready var _wave_generator: WaveGenerator = %WaveGenerator


func _ready() -> void:
	_wave_component.wave_completed.connect(next_wave)
	next_wave()


func next_wave() -> void:
	_wave_generator.generate()
	_wave_component.start()
	_display_wave_label()


func _display_wave_label() -> void:
	%WaveLabel.text = "Wave " + str(_wave_generator.get_current_wave())
	%AnimationPlayer.play("wave_announcement")
