extends Node2D

onready var world = $World

var level1 = preload("res://scenes/level_1.tscn")


func _ready():
	world.add_child(level1.instance())


func change_level(level):
	if world.get_child_count() > 0:
		world.get_children()[0].queue_free()
	world.add_child(level)
