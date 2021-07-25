extends RichTextLabel

onready var timer: Timer = $Timer
export var text_speed := 0.05
var player_visible := false


func _on_Timer_timeout():
	if visible_characters < text.length() && player_visible:
		visible_characters = visible_characters + 1

	if visible_characters > 0 && ! player_visible:
		visible_characters = visible_characters - 1


func _on_Area2D_body_entered(body):
	player_visible = true
	timer.start(text_speed)


func _on_Area2D_body_exited(body):
	player_visible = false
