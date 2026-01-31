@tool
class_name VisionBlocker
extends CanvasLayer

const SPLOT_SCENE := preload("res://player/vision_blocker/splot.tscn")

@export_tool_button("Randomize", "RandomNumberGenerator")
var _trigger_action: Callable = _spread

@export var _spacing := 196
@export var _wiggle := 32.0

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
		remove_child(child)
		_hidden.add_child(child)


func splat() -> void:
	if _hidden.get_child_count() == 0:
		return

	var index := randi() % _hidden.get_child_count()

	var splot := _hidden.get_child(index)
	_hidden.remove_child(splot)
	_visible.add_child(splot)


func _spread() -> void:
	if not Engine.is_editor_hint():
		return
		
	print("Randomizing splots!")

	for child in get_children():
		remove_child(child)
		child.queue_free()

	var viewport_size := Vector2i(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height"),
	)
	var count := Vector2i(viewport_size.x / _spacing + 1, viewport_size.y / _spacing + 1)
	var edge := Vector2(viewport_size.x % _spacing, viewport_size.x % _spacing)

	for x in count.x:
		for y in count.y:
			var splot: Sprite2D = SPLOT_SCENE.instantiate()
			add_child(splot)
			splot.name = "Splot (%d, %d)" % [x, y]
			splot.owner = self
			splot.global_position = Vector2(x * _spacing + edge.x / 2.0, y * _spacing + edge.y / 2.0)
			splot.global_position += Vector2(randf_range(-_wiggle, _wiggle), randf_range(-_wiggle, _wiggle))
			splot.rotation = randf_range(0, TAU)
			splot.modulate = Color(randf(), randf(), randf())
