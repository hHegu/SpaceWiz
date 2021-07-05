extends Area2D

var speed = 400
var dir = Vector2()
var velocity = Vector2()

func start(direction: Vector2):
	rotation = direction.angle()
	dir = direction.normalized() * speed

func _physics_process(delta):
	position += dir * delta


func _on_Laser_body_entered(body):
	if(body.has_method("hit")):
		body.hit()
	queue_free()
	pass # Replace with function body.
