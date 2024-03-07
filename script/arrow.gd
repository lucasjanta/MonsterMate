extends Area2D

var attack_damage := 50.0
var speed = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	
func arrow_deal_damage():
	pass


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.has_method("take_damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		print("certo?")
		body.take_damage(attack)
