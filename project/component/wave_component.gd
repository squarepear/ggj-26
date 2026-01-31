class_name WaveComponent
extends Node

@export var target : CharacterBody2D

func start_wave():
	for child in get_children():
		child.spawn(target)
