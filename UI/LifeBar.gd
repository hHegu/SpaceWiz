extends TextureProgress


# Called when the node enters the scene tree for the first time.
func _ready():
	value = GameManager.player_health
	GameManager.connect("on_player_health_change", self, "on_player_health_change")
	pass  # Replace with function body.


func on_player_health_change(health):
	value = health
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
