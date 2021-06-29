extends KinematicBody2D
class_name Actor

# A class that all actors shoud inherit
const FLOOR_NORMAL := Vector2.UP

export var speed := Vector2(200.0, 400.0)
export var gravity := 1500.0

# Horizontal slowdown on the ground
export var friction := 0.15

# Horizontal slowdown in the air
export var air_friction := 0.03

var _velocity := Vector2.ZERO

var is_floored := false


func _physics_process(delta: float) -> void:
	is_floored = is_on_floor()
	if !is_floored:
		_velocity.y += gravity * delta
		_velocity.x = lerp(_velocity.x, 0, air_friction)
	else:
		_velocity.y = 0
		_velocity.x = lerp(_velocity.x, 0, friction)

