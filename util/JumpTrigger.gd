extends Area2D
class_name JumpTrigger

export var jump_height := 20.0 
export var jump_length := 20.0

func get_jump_dir(dir_x: float):
	return Vector2(dir_x * jump_length, -jump_height)
