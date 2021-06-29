extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var walk_time := 4.0
export var idle_time :=	4.0

enum {patrol, alert}

var current_state := patrol

var walk_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _on_timer_finish():
	pass
