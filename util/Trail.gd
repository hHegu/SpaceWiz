extends Line2D
export (NodePath) var targetPath
export var trailLength = 4


func _ready():
	set_as_toplevel(true)


func _physics_process(delta):
	var point = get_parent().global_position
	add_point(point)

	if points.size() > 10:
		remove_point(0)
