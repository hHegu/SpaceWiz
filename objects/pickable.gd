extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var lock_rotation := false
export var hover_modulate :Color
var is_being_lifted := false

var initial_grav_scale :int
var initial_modulate :Color

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_modulate = modulate
	initial_grav_scale = gravity_scale
	if(lock_rotation):
		mode = RigidBody2D.MODE_CHARACTER
	pass # Replace with function body.
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_released("lift")):
		modulate = initial_modulate
		is_being_lifted = false
		angular_damp = -1
		gravity_scale = initial_grav_scale

	if(is_being_lifted):
		modulate = hover_modulate		
		gravity_scale = 0
		var force_dir = get_global_mouse_position() - global_position
		linear_velocity = force_dir * 4


func _on_box_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("lift"):
			is_being_lifted = true
	pass # Replace with function body.
