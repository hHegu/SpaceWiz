extends Enemy

onready var gun_point = $Body/AnimatedSprite/Gun

var Laser = preload("res://weapons/Laser.tscn")
var attack_timer = Timer.new()
export var fire_rate := 1.0
export var accuracy := 0.8


func _ready():
	attack_timer.wait_time = fire_rate
	attack_timer.one_shot = false
	add_child(attack_timer)
	attack_timer.connect("timeout", self, "shoot_laser")
	vision_area.connect("player_seen", self, "on_player_is_seen")
	

func shoot_laser():
	if is_in_range && !is_being_lifted && is_on_floor:
		var l = Laser.instance()
		l.global_position = gun_point.global_position
		l.start(vision_area.get_direction_to_player())
		get_parent().add_child(l)
		animated_sprite.frame = 0
		animated_sprite.play("shoot")

func on_player_is_seen():
	attack_timer.start(fire_rate)
