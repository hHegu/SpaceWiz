extends Light2D

onready var tween: Tween = $Tween

export var flash_time := 1.0
export var initial_energy := 1.0


func _ready():
	tween.interpolate_property(
		self, "energy", initial_energy, 0, flash_time, Tween.TRANS_BOUNCE, Tween.EASE_OUT
	)
	tween.start()
