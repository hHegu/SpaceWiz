extends RigidBody2D
class_name Pickable

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var lock_rotation := false
export var hover_modulate: Color
var is_being_lifted := false

var initial_grav_scale: int
var initial_modulate: Color

var past_velocities := [0.0, 0.0]
var timer := Timer.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("input_event", self, "_on_box_input_event")
	connect("body_entered", self, "_on_body_entered")
	initial_modulate = modulate
	initial_grav_scale = gravity_scale
	if lock_rotation:
		mode = RigidBody2D.MODE_CHARACTER

	add_child(timer)
	timer.wait_time = 0.1
	timer.one_shot = false
	timer.connect("timeout", self, "store_last_velocity")
	timer.start()
	pass  # Replace with function body.


func store_last_velocity():
	past_velocities[1] = past_velocities[0]
	past_velocities[0] = linear_velocity.length_squared()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_released("lift"):
		modulate = initial_modulate
		is_being_lifted = false
		angular_damp = -1
		gravity_scale = initial_grav_scale

	if is_being_lifted:
		modulate = hover_modulate
		gravity_scale = 0
		var force_dir = get_global_mouse_position() - global_position
		linear_velocity = force_dir * 4


func _on_box_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("lift"):
			is_being_lifted = true


func _on_body_entered(body: Node2D):
	var object_vel = (
		0
		if ! body.get('linear_velocity')
		else body.get('linear_velocity').length_squared()
	)
	var relative_vel = abs(object_vel - past_velocities[1])
	print(name + '=')
	print(relative_vel)
	if relative_vel > 30000:
		if body.has_method("hit"):
			body.hit()
		if self.has_method("hit"):
			self.call('hit')
