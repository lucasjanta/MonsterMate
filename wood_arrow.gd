extends Node2D

var attack_damage := 10.0
var bow_damage : float
var speed = 200
var direction: Vector2 = Vector2.ZERO
signal arrow_hit
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	set_as_top_level(true)
	direction = global_position.direction_to(get_global_mouse_position())
	var angle = direction.angle()
	rotation_degrees = rad_to_deg(angle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	translate(direction * delta * speed)

func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage + bow_damage
		print("o dano foi de ", attack.attack_damage)
		body.take_damage(attack)


func _on_visible_on_screen_enabler_2d_screen_exited():
	print("sumiu")
	queue_free()

