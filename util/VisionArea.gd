extends Node2D
class_name VisionArea

onready var raycast_to_player: RayCast2D = $RaycastToPlayer
onready var check_interval_timer: Timer = $CheckIntervalTimer
var is_player_in_vision_range := false
var is_player_seen := false
var player_body: KinematicBody2D
signal player_seen


func _ready():
	player_body = get_tree().get_root().find_node("Player", true, false)
	print(player_body)


func _process(delta):
	raycast_to_player.scale.x = get_parent().scale.x


func _on_Area2D_body_entered(body: Node2D) -> void:
	player_body = body
	raycast_player()
	is_player_in_vision_range = true
	check_interval_timer.start()


func _on_Area2D_body_exited(body: Node) -> void:
	is_player_in_vision_range = false


func _on_CheckIntervalTimer_timeout() -> void:
	if is_player_seen:
		return

	is_player_seen = raycast_player()

	if !is_player_seen && is_player_in_vision_range:
		check_interval_timer.start()
	
	if is_player_seen:
		emit_signal("player_seen")


func get_player() -> KinematicBody2D:
	return player_body


func get_direction_to_player() -> Vector2:
	return global_position.direction_to(player_body.global_position)


func get_distance_to_player() -> float:
	return global_position.distance_to(player_body.global_position)


func raycast_player():
	raycast_to_player.cast_to = player_body.global_position - self.global_position
	if raycast_to_player.is_colliding():
		var collided_body = raycast_to_player.get_collider()
		return collided_body.get_name() == 'Player'
	return false


func get_player_raycast():
	raycast_player() 
	return raycast_to_player
