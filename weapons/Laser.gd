extends Area2D

var speed = 300
var dir = Vector2()

var particle_effect = preload("LaserHitEffect.tscn")


func start(direction: Vector2):
	rotation = direction.angle()
	dir = direction.normalized() * speed


func _physics_process(delta):
	position += dir * delta


func _on_Laser_body_entered(body: Node2D):
	if body.has_method("hit"):
		body.hit()
	var p_effect_instance = particle_effect.instance()
	p_effect_instance.global_position = global_position
	get_parent().call_deferred("add_child", p_effect_instance)
	queue_free()


func _on_Laser_area_entered(area):
	if area.is_in_group("ricochet"):
		dir = (get_global_mouse_position() - global_position).normalized() * speed
		rotation = dir.angle()
		# 4 = objects, 8 = enemy, 16 = ground
		collision_mask = 4 + 8 + 16
