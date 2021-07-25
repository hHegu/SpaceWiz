extends Level

onready var enemies: Node = $enemies


func _process(delta):
	var enemy = enemies.get_node_or_null("Robot2")
	if enemy == null && ! GameManager.exit_door_open:
		GameManager.exit_door_open = true
