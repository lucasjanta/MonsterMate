extends CharacterBody2D

var speed = 100

@onready var anim = $AnimatedSprite2D
var player_state

@export var inv: Inv

var bow_equipped = false
var bow_cooldown = true
var arrow = preload("res://scenes/arrow.tscn")

var mouse_loc_from_player = null

func _physics_process(delta):
	mouse_loc_from_player = get_global_mouse_position() - self.position
	#print(mouse_loc_from_player)
	
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("pick"):
		bow_equipped = !bow_equipped
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("left_mouse") and bow_equipped and bow_cooldown:
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		
		await get_tree().create_timer(0.4).timeout
		bow_cooldown = true
	
	play_anim(direction)
	
func play_anim(dir):
	if !bow_equipped:
		speed = 100
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
	if bow_equipped:
		speed = 50
		if mouse_loc_from_player.x >= -25 and mouse_loc_from_player.x <= 25 and mouse_loc_from_player.y < 0:
			anim.play("n-attack")
		if mouse_loc_from_player.y >= -25 and mouse_loc_from_player.y <= 25 and mouse_loc_from_player.x >  0:
			anim.play("e-attack")
		if mouse_loc_from_player.x >= -25 and mouse_loc_from_player.x <= 25 and mouse_loc_from_player.y > 0:
			anim.play("s-attack")
		if mouse_loc_from_player.y >= -25 and mouse_loc_from_player.y <= 25 and mouse_loc_from_player.x < 0:
			anim.play("w-attack")
			
		if mouse_loc_from_player.x >= 25 and mouse_loc_from_player.y <= -25:
			anim.play("ne-attack")
		if mouse_loc_from_player.x >= 0.5 and mouse_loc_from_player.y >= 25:
			anim.play("se-attack")
		if mouse_loc_from_player.x <= -0.5 and mouse_loc_from_player.y >= -5:
			anim.play("sw-attack")
		if mouse_loc_from_player.x <= -25 and mouse_loc_from_player.y <= -25:
			anim.play("nw-attack")
func player():
	pass
func collect(item):
	inv.insert(item)

