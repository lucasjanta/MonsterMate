extends CharacterBody2D
class_name Player

@export var inv: Inv
@export var speed = 100
@export var health = 100
@onready var anim = $AnimatedSprite2D

var player_state
var last_state
#var normalizeRotation = 57.14

var equipped_weapon : String = "none"
var isEquipped = false
var isAttacking = false
@onready var fire_weapon = preload("res://weapons/sword/fire_sword.tscn")
@onready var air_weapon = preload("res://weapons/bow/air_bow.tscn")
var weapon_instance

var mouse_loc_from_player = null

func _physics_process(delta):
	if health <= 0:
		queue_free()
	#mouse_loc_from_player = get_global_mouse_position() - self.position
	#print(mouse_loc_from_player)
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()

	if Input.is_action_just_pressed("fire_weapon"):
		equip_weapon("fire")
	if Input.is_action_just_pressed("water_weapon"):
		equip_weapon("water")
	if Input.is_action_just_pressed("air_weapon"):
		equip_weapon("air")

	play_anim(direction)
	if isEquipped:
		weapon_instance.animate(get_direction(), get_mouse_position())
		
	
# pega a direção do mouse e retorna x e y 
func get_direction() -> Vector2:
	return global_position.direction_to(get_mouse_position())

func get_mouse_position() -> Vector2:
	return get_global_mouse_position()

func play_anim(dir):
	speed = 100
	if player_state == "idle":
		if last_state == "up":
			anim.play("idle_up")
		if last_state == "right":
			anim.play("idle_right")
		if last_state == "down":
			anim.play("idle_down")
		if last_state == "left":
			anim.play("idle_left")
	if player_state == "walking":
		if dir.y == -1:
			anim.play("walk_up")
			last_state = "up"
		if dir.x == 1:
			anim.play("walk_right")
			last_state = "right"
		if dir.y == 1:
			anim.play("walk_down")
			last_state = "down"
		if dir.x == -1:
			anim.play("walk_left")
			last_state = "left"
			
func player():
	pass

func collect(item):
	inv.insert(item)
	
func equip_weapon(choosen_weapon):
	if choosen_weapon == "fire" and equipped_weapon != "fire":
		if weapon_instance != null:
			weapon_instance.queue_free()
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
		if weapon_instance != null:
			weapon_instance.queue_free()
		equipped_weapon = "air"
		isEquipped = true
		weapon_instance = air_weapon.instantiate()
		add_child(weapon_instance)
	elif choosen_weapon == "air" and equipped_weapon == "air":
		print("air weapon unequipped")
		equipped_weapon = "none"
		isEquipped = false
		if weapon_instance != null:
			weapon_instance.queue_free()
