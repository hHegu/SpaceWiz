extends Pickable

onready var animated_sprite: AnimatedSprite = $AnimatedSprite

var impulse_min_strength := 100.0
var impulse_max_strength := 170.0

enum body_parts { hand, torso, head, gun }

var body_part = body_parts.head


func _ready():
	print(body_part)
	animated_sprite.frame = body_part
	randomize()
	var impulse_strength = (
		randf() * (impulse_max_strength - impulse_min_strength)
		+ impulse_min_strength
	)
	randomize()
	apply_impulse(Vector2.ZERO, Vector2(randf() * 2 - 1, -randf()).normalized() * impulse_strength)
