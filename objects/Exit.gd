extends Area2D

onready var sprite: AnimatedSprite = $AnimatedSprite


func _ready():
	GameManager.connect("on_exit_door_open", self, "on_exit_door_open")


func on_exit_door_open():
	sprite.play("open")


func _on_Exit_body_entered(body):
	if GameManager.exit_door_open:
		print("jee")
