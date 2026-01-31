@tool
class_name VisionBlocker
extends CanvasLayer

const SPLOT_SCENE := preload("res://player/vision_blocker/splot.tscn")

@export var _randomize := false

@onready var _hidden := Node2D.new()
@onready var _visible := Node2D.new()


func _ready() -> void:
	if Engine.is_editor_hint():
		return

	var splots: Array[Node] = get_children()

	add_child(_hidden)
	add_child(_visible)

	_hidden.hide()
	_visible.show()
	show()

	for child in splots:
		print(child)
		remove_child(child)
		_hidden.add_child(child)


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return

	if _randomize:
		_spread()
		_randomize = false


func splat() -> void:
	print("SPLAT")
	if _hidden.get_child_count() == 0:
		return

	var index := randi() % _hidden.get_child_count()

	print("SPLAT i", index)
	var splot := _hidden.get_child(index)
	_hidden.remove_child(splot)
	_visible.add_child(splot)


func _spread() -> void:
	for child in get_children():
		child.queue_free()

	var spacing := 200.0
	for x in 10:
		for y in 6:
			var splot: Sprite2D = SPLOT_SCENE.instantiate()
			add_child(splot, true, Node.INTERNAL_MODE_DISABLED)
			splot.owner = self
			splot.global_position = Vector2(x * spacing + spacing / 2.0, y * spacing + spacing / 2.0)
			splot.rotation = randf_range(0, TAU)
			splot.modulate = Color(randf(), randf(), randf())
