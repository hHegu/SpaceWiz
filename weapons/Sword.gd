extends Area2D

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var shape: CollisionShape2D = $CollisionShape2D
onready var light: Light2D = $Light2D
onready var tween: Tween = $Tween


func _process(delta):
	if Input.is_action_just_pressed("fire") && ! GameManager.is_player_dead():
		light.energy = 1
		tween.interpolate_property(
			light, "energy", light.energy, 0, 1, Tween.TRANS_QUART, Tween.EASE_OUT
		)
		tween.start()
		shape.disabled = false
		animated_sprite.play("slash")


func _on_AnimatedSprite_animation_finished():
	shape.disabled = true
	animated_sprite.play("default")


func _on_Sword_body_entered(body):
	if body.has_method("hit"):
		body.hit()
