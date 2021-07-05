extends Pickable
class_name Enemy

onready var body: Node2D = $Body
onready var animated_sprite: AnimatedSprite = $Body/AnimatedSprite
onready var ground_check: Area2D = $Body/GroundCheck
onready var wall_check: RayCast2D = $Body/WallCheck
onready var vision_area: VisionArea = $Body/VisionArea
onready var jump_check: Area2D = $JumpCheck

export var walk_time := 3.0
export var idle_time :=	4.0
export var attack_range := 100
export(int, "left", "right") var initial_direction
export var can_jump := true

enum {patrol_walk, patrol_idle, alert}

var current_state := patrol_idle
var walk_timer := Timer.new()
var _walk_direction := Vector2.RIGHT
var is_in_range := false
var is_on_floor := true
var is_jumping := false
var last_jump_time := 0.0

func setup_timers():
	add_child(walk_timer)
	walk_timer.connect("timeout", self, "on_walk_timer_timeout")
	walk_timer.wait_time = idle_time
	walk_timer.one_shot = true
	walk_timer.start()


func setup_vision_area():
	vision_area.connect("player_seen", self, "player_seen")


# Called when the node enters the scene tree for the first time.
func _ready():
	if initial_direction == 1:
		flip()
	current_state = patrol_idle
	setup_timers()
	setup_vision_area()
	jump_check.connect("area_entered", self, "on_jump_check_enter")


func _physics_process(delta):

	var is_alert = current_state == alert
	is_on_floor = check_is_on_floor()
	
	if is_being_lifted:
		animated_sprite.play("helpless_air")
		current_state = alert
		return
	
	# Hack to get jumping work
	if is_on_floor && is_jumping && OS.get_ticks_msec() - last_jump_time > 500:
		is_jumping = false
		return
	
	if !is_on_floor || is_jumping:
		return
	
	if !is_alert && is_next_to_wall() && current_state == patrol_walk && walk_timer.wait_time - walk_timer.time_left > 0.2:
		start_idling()

	hande_states()


func hande_states():
	match current_state:
		patrol_walk:
			animated_sprite.play("walk")
			linear_velocity = _walk_direction * 30
			pass
		patrol_idle:
			animated_sprite.play("idle")
			pass
		alert:
			is_in_range = vision_area.get_distance_to_player() < attack_range && vision_area.raycast_player()
			var direction_vector = Vector2(vision_area.get_direction_to_player().x, 0).normalized()
			body.scale.x = direction_vector.x

			if !is_in_range:
				linear_velocity = direction_vector * 30
				animated_sprite.play("walk")
			pass


func start_walking():
	walk_timer.stop()	
	current_state = patrol_walk
	walk_timer.wait_time = walk_time
	walk_timer.start()


func start_idling():
	walk_timer.stop()
	current_state = patrol_idle
	walk_timer.wait_time = idle_time
	walk_timer.start()


func on_walk_timer_timeout():
	if current_state == patrol_idle:
		flip()
		start_walking()
		return

	if current_state == patrol_walk:
		start_idling()
		return


func check_is_on_floor():
	return ground_check.get_overlapping_bodies().size() > 0


func is_next_to_wall():
	return wall_check.is_colliding()


func flip():
	_walk_direction = _walk_direction * -1	
	body.scale.x *= -1

func player_seen():
	current_state = alert

func on_jump_check_enter(jump_trigger: JumpTrigger):
	if(can_jump && jump_trigger.has_method("get_jump_dir")):
		jump(jump_trigger.get_jump_dir(_walk_direction.normalized().x))

func jump(dir: Vector2):
	is_jumping = true
	last_jump_time = OS.get_ticks_msec()
	set_linear_velocity(dir)
