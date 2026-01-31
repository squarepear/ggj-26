extends Node2D

const GAME_OVER = preload("res://menus/game_over_menu.tscn")

@onready var _wave_component: WaveComponent = %WaveComponent
@onready var _wave_generator: WaveGenerator = %WaveGenerator
@onready var _death_sound: AudioStreamPlayer = %DeathSound


var _game_over := false
var player_living := true

func _ready() -> void:
	_wave_component.wave_completed.connect(next_wave)
	next_wave()


func next_wave() -> void:
	if player_living:
		_wave_generator.generate()
		_display_wave_label()


func _display_wave_label() -> void:
	%WaveLabel.text = "Wave " + str(_wave_generator.get_current_wave())
	%AnimationPlayer.play("wave_announcement")


func _on_player_killed() -> void:
	if !_game_over:
		_death_sound.play()
		player_living = false
		_game_over = true
		var _game_over = GAME_OVER.instantiate()
		%CanvasLayer.add_child(_game_over)
		_game_over.update_waves_label(_wave_generator.get_current_wave())
