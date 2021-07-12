extends Node

var player_health = 3 setget player_health_set, player_health_get
var is_dead := false
var exit_door_open := false setget exit_door_open_set, exit_door_open_get


signal on_player_health_change
signal on_player_death
signal on_exit_door_open
signal on_level_change

# Levels
var level1 = preload("res://scenes/level_1.tscn")
var level2 = preload("res://scenes/level_2.tscn")

var current_level = level1 setget current_level_set, current_level_get

func player_health_set(health: int):
	player_health = health
	if player_health == 0:
		is_dead = true
		emit_signal("on_player_death")
	emit_signal("on_player_health_change", player_health)

func player_health_get():
	return player_health


func exit_door_open_set(is_open: bool):
	exit_door_open = is_open
	if is_open:
		emit_signal("on_exit_door_open")

func exit_door_open_get():
	return exit_door_open
	
func current_level_set(level):
	current_level = level
	emit_signal("on_level_change")

func current_level_get():
	return exit_door_open
