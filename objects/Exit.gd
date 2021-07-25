extends Area2D

onready var sprite: AnimatedSprite = $AnimatedSprite
onready var light: Light2D = $Light2D

export var destination_level: String


func _ready():
	GameManager.connect("on_exit_door_open", self, "on_exit_door_open")


func on_exit_door_open():
	sprite.play("open")
	light.enabled = true


func _on_Exit_body_entered(body):
	if GameManager.exit_door_open:
		GameManager.exit_door_open = false
		GameManager.current_level = GameManager.get(destination_level)
