extends Control

onready var panel: Panel = $Panel
onready var tween: Tween = $Tween

signal on_fade_in_finished
signal on_fade_out_finished


func _ready():
	visible = true
	GameManager.connect("on_level_loaded", self, "fade_in")
	GameManager.connect("on_level_changed", self, "fade_out")


func fade_in():
	tween.interpolate_property(
		panel, "modulate", panel.modulate, Color.transparent, 0.3, Tween.TRANS_LINEAR
	)
	tween.start()


func fade_out():
	tween.interpolate_property(
		panel, "modulate", panel.modulate, Color.black, 0.3, Tween.TRANS_LINEAR
	)
	tween.start()


func _on_Tween_tween_all_completed():
	if panel.modulate == Color.black:
		emit_signal("on_fade_out_finished")
	if panel.modulate == Color.transparent:
		emit_signal("on_fade_in_finished")
