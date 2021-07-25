extends Enemy

var body_part = preload("Bodypart.tscn")
var death_effect = preload("DeathEffect.tscn")
onready var gun_point = $Body/AnimatedSprite/Gun

var Laser = preload("res://weapons/Laser.tscn")
var attack_timer = Timer.new()
export var fire_rate := 1.0
export var accuracy := 0.8

var hand = body_part.instance()
var hand1 = body_part.instance()
var hand2 = body_part.instance()
var hand3 = body_part.instance()
var head = body_part.instance()
var torso = body_part.instance()
var gun = body_part.instance()


func _ready():
	attack_timer.wait_time = fire_rate
	attack_timer.one_shot = false
	add_child(attack_timer)
	attack_timer.connect("timeout", self, "shoot_laser")
	vision_area.connect("player_seen", self, "on_player_is_seen")
	GameManager.connect("on_player_death", self, "on_player_death")


func shoot_laser():
	if is_in_range && ! is_being_lifted && is_on_floor:
		var l = Laser.instance()
		l.global_position = gun_point.global_position
		l.start(vision_area.get_direction_to_player())
		get_parent().add_child(l)
		animated_sprite.frame = 0
		animated_sprite.play("shoot")


func on_player_is_seen():
	attack_timer.start(fire_rate)


func on_player_death():
	attack_timer.stop()


func hit():
	hand.body_part = hand.body_parts.hand
	hand.global_position = global_position

	hand1.body_part = hand1.body_parts.hand
	hand1.global_position = global_position

	head.body_part = head.body_parts.head
	head.global_position = global_position

	torso.body_part = torso.body_parts.torso
	torso.global_position = global_position

	gun.body_part = gun.body_parts.gun
	gun.global_position = global_position

	var death_effect_instance = death_effect.instance()
	death_effect_instance.global_position = global_position

	var parent = get_parent()
	parent.call_deferred("add_child", hand)
	parent.call_deferred("add_child", hand1)
	parent.call_deferred("add_child", head)
	parent.call_deferred("add_child", torso)
	parent.call_deferred("add_child", gun)
	parent.call_deferred("add_child", death_effect_instance)

	queue_free()


func die():
	hit()
