extends Actor

#var sword_slash = preload("res://src/skills/SwordSlash.tscn")

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var hand: Node2D = $HandStart
var jumped := false
var looking_up := false
var looking_down := false
var bounce_speed := 300.0
var push = 4


func _ready():
	animated_sprite.play("idle")


func _physics_process(_delta: float) -> void:
	is_floored = is_on_floor()
	var direction := get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	var snap: Vector2 = Vector2.DOWN * 10.0 if direction.y == 0.0 else Vector2.ZERO
	_velocity = move_and_slide_with_snap(_velocity, snap, FLOOR_NORMAL, true, 4,  PI/4, false)
	handle_animations()
	handle_collisions_with_objects()
	handle_hand_movements()


func get_direction() -> Vector2:
	var horizontal_input = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
	)
	var vertical_input = (
		-Input.get_action_strength("jump")
		if is_floored and Input.is_action_just_pressed("jump")
		else 0.0
	)
	jumped = vertical_input < 0

	return Vector2(horizontal_input, vertical_input)


func calculate_move_velocity(linear_velocity: Vector2, direction: Vector2, speed: Vector2) -> Vector2:
	var velocity := linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	return velocity


func handle_animations() -> void:
	if _velocity.x > 0.1:
		animated_sprite.scale.x = 1
	elif _velocity.x < -0.1:
		animated_sprite.scale.x = -1

	if is_floored and abs(_velocity.x) > 0:
		animated_sprite.play('walk')

	if is_floored and abs(_velocity.x) == 0:
		animated_sprite.play('idle')
	
	if !is_floored:
		animated_sprite.play('jump')


func handle_collisions_with_objects() -> void:
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("objects"):
			collision.collider.apply_central_impulse(-collision.normal * push)


func handle_hand_movements() -> void:
	if Input.is_action_pressed("lift"):
		hand.look_at(get_global_mouse_position())
		hand.visible = true		
	else:
		hand.visible = false
