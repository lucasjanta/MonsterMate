extends CharacterBody2D

var speed = 100

@onready var anim = $AnimatedSprite2D
var player_state

@export var inv: Inv

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	
	play_anim(direction)
	
func play_anim(dir):
	if player_state == "idle":
		anim.play("idle")
	if player_state == "walking":
		if dir.y == -1:
			anim.play("n-walk")
		if dir.x == 1:
			anim.play("e-walk")
		if dir.y == 1:
			anim.play("s-walk")
		if dir.x == -1:
			anim.play("w-walk")
			
		if dir.x > 0.5 and dir.y < -0.5:
			anim.play("ne-walk")
		if dir.x > 0.5 and dir.y > 0.5:
			anim.play("se-walk")
		if dir.x < -0.5 and dir.y < -0.5:
			anim.play("nw-walk")
		if dir.x < -0.5 and dir.y > 0.5:
			anim.play("sw-walk")
			
func player():
	pass
		
