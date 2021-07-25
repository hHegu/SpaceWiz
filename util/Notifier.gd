extends Area2D
class_name Notifier

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var collision_shape: CollisionShape2D = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func enable():
	collision_shape.disabled = false


func _on_Notifier_body_entered(body):
	if body.has_method('player_seen'):
		body.player_seen()
