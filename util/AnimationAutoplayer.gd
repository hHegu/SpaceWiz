extends AnimationPlayer

export var animation: String

# Called when the node enters the scene tree for the first time.
func _ready():
	play(animation)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
