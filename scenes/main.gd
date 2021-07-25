extends Node2D

onready var world = $World
onready var fade = $CanvasLayer/Fade
var level_path: String


func _ready():
	on_level_changed(GameManager.level1)
	on_fade_out_finished()
	fade.connect("on_fade_out_finished", self, "on_fade_out_finished")
	GameManager.connect("on_level_change", self, "on_level_changed")


func on_level_changed(level: String):
	level_path = level
	fade.fade_out()


func on_fade_out_finished():
	for n in world.get_children():
		world.remove_child(n)
		n.queue_free()

	var level_instance = load(level_path).instance()
	world.call_deferred("add_child", level_instance)
