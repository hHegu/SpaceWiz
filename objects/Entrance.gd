extends Area2D

onready var animated_sprite: AnimatedSprite = $AnimatedSprite


func _ready():
	animated_sprite.playing = true
