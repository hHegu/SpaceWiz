extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var enemies: Node = $enemies


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func _process(delta):
	var enemy = enemies.get_node_or_null("Robot2")
	if enemy == null && ! GameManager.exit_door_open:
		GameManager.exit_door_open = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
