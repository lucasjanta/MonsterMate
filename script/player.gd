extends CharacterBody2D
class_name Player

@export var speed = 100
@export var health = 100

@onready var anim = $AnimatedSprite2D
var player_state

@export var inv: Inv

var equipped_weapon : String = "none"
var isEquipped = false
var isAttacking = false
var fire_weapon = preload("res://weapons/sword/fire_sword.tscn")
var weapon_instance


var bow_equipped = false
var bow_cooldown = true
var arrow = preload("res://scenes/arrow.tscn")
var mouse_loc_from_player = null

func _physics_process(delta):
	if health <= 0:
		queue_free()
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
	if Input.is_action_just_pressed("fire_weapon"):
		equip_weapon("fire")
	if Input.is_action_just_pressed("water_weapon"):
		equip_weapon("water")
	if Input.is_action_just_pressed("air_weapon"):
		equip_weapon("air")
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	weapon_instance.rotation = $Marker2D.rotation
		
	
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
	var quarenta_cinco_graus = 0.7875
	var noventa_graus = quarenta_cinco_graus * 2
	#if isEquipped:
		#if dir.x > 0: 
			#weapon_instance.rotation = 0 
			#if dir.y < 0:
				#weapon_instance.rotation = -quarenta_cinco_graus
			#if dir.y > 0:
				#weapon_instance.rotation = quarenta_cinco_graus
		#if dir.x < 0:
			#weapon_instance.rotation = noventa_graus * 2 
			#if dir.y < 0:
				#weapon_instance.rotation = -noventa_graus -quarenta_cinco_graus
			#if dir.y > 0:
				#weapon_instance.rotation = noventa_graus * 2 - quarenta_cinco_graus
		#if dir.y == 1:
			#weapon_instance.rotation = noventa_graus + quarenta_cinco_graus
		#if dir.x > 0 and dir.y > 0:
			#weapon_instance.rotation = quarenta_cinco_graus * 5
		#if dir.x == 0 and dir.y == -1:
			#weapon_instance.rotation = quarenta_cinco_graus * 7
		#if dir.x == 0 and dir.y == 1:
			#weapon_instance.rotation = quarenta_cinco_graus * 3
	#if isEquipped and !isAttacking:
		#if dir.x == 1 and dir.y == 0:
			#weapon_instance.rotation = quarenta_cinco_graus * 3
		#if dir.x == -1 and dir.y == 0:
			#weapon_instance.rotation = quarenta_cinco_graus * 7
		#if dir.x == 0 and dir.y == -1:
			#weapon_instance.rotation = quarenta_cinco_graus * 9
		#if dir.x == 0 and dir.y == 1:
			#weapon_instance.rotation = quarenta_cinco_graus * 5
	
		#if dir.x > 0.5 and dir.y < -0.5:
			#weapon_instance.rotation = 0
		#if dir.x > 0.5 and dir.y > 0.5:
			#weapon_instance.rotation = quarenta_cinco_graus * 2
		#if dir.x < -0.5 and dir.y < -0.5:
			#weapon_instance.rotation = quarenta_cinco_graus * 6
		#if dir.x < -0.5 and dir.y > 0.5:
			#weapon_instance.rotation = quarenta_cinco_graus * 4
		
			
	if !bow_equipped:
		speed = 100
		if player_state == "idle":
			anim.play("idle_right")
		if player_state == "walking":
			if dir.y == -1:
				anim.play("walk_up")
			if dir.x == 1:
				anim.play("walk_right")
			if dir.y == 1:
				anim.play("walk_down")
			if dir.x == -1:
				anim.play("walk_left")
			
			#if dir.x > 0.5 and dir.y < -0.5:
				#anim.play("ne-walk")
			#if dir.x > 0.5 and dir.y > 0.5:
				#anim.play("se-walk")
			#if dir.x < -0.5 and dir.y < -0.5:
				#anim.play("nw-walk")
			#if dir.x < -0.5 and dir.y > 0.5:
				#anim.play("sw-walk")
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
			
		#if mouse_loc_from_player.x >= 25 and mouse_loc_from_player.y <= -25:
			#anim.play("ne-attack")
		#if mouse_loc_from_player.x >= 0.5 and mouse_loc_from_player.y >= 25:
			#anim.play("se-attack")
		#if mouse_loc_from_player.x <= -0.5 and mouse_loc_from_player.y >= -5:
			#anim.play("sw-attack")
		#if mouse_loc_from_player.x <= -25 and mouse_loc_from_player.y <= -25:
			#anim.play("nw-attack")
func player():
	pass

func collect(item):
	inv.insert(item)
	
func equip_weapon(choosen_weapon):
	if choosen_weapon == "fire" and equipped_weapon != "fire":
		print("fire weapon equipped")
		equipped_weapon = "fire"
		isEquipped = true
		weapon_instance = fire_weapon.instantiate()
		#weapon_instance.rotation = $Marker2D.rotation
		weapon_instance.rotation = 0
		#weapon_instance.global_position = $Marker2D.position
		add_child(weapon_instance)
	elif choosen_weapon == "fire" and equipped_weapon == "fire":
		print("fire weapon unequipped")
		equipped_weapon = "none"
		isEquipped = false
		if weapon_instance != null:
			weapon_instance.queue_free()
	if choosen_weapon == "water" and equipped_weapon != "water":
		print("water weapon equipped")
		equipped_weapon = "water"
		isEquipped = true
	elif choosen_weapon == "water" and equipped_weapon == "water":
		print("water weapon unequipped")
		equipped_weapon = "none"
		isEquipped = false
	if choosen_weapon == "air" and equipped_weapon != "air":
		print("air weapon equipped")
		equipped_weapon = "air"
		isEquipped = true
	elif choosen_weapon == "air" and equipped_weapon == "air":
		print("air weapon unequipped")
		equipped_weapon = "none"
		isEquipped = false
	


