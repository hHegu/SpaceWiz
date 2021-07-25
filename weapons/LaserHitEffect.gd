extends Particles2D

onready var light = $Light2D
onready var tween = $Tween


func _ready():
	tween.interpolate_property(
		light, "energy", light.energy, 0, 1, Tween.TRANS_BOUNCE, Tween.EASE_OUT
	)
	tween.start()
	emitting = true


func _process(delta):
	if ! emitting:
		queue_free()
