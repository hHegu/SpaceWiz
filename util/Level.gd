extends Node
class_name Level


func _enter_tree():
	GameManager.emit_signal("on_level_loaded")
