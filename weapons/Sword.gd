extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var shape: CollisionShape2D = $CollisionShape2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fire") && !GameManager.is_dead:
		shape.disabled = false
		animated_sprite.play("slash")


func _on_AnimatedSprite_animation_finished():
	shape.disabled = true
	animated_sprite.play("default")
	pass # Replace with function body.


func _on_Sword_body_entered(body):
	if body.has_method("hit"):
		body.hit()
	pass # Replace with function body.
