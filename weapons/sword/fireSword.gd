extends Node2D

@export var weapon : Weapons
var atk_damage : float
var knockback_force : float
var side = -1
var isAttacking = false
var isCharging = false
var attackTime := 0.25
var attackForce : float = 5.5
@onready var sprite = $sword/Sprite2D
@onready var anim = $AnimationPlayer
@onready var sword = $sword
@onready var collision = $sword/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	load_weapon()
	collision.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left_mouse"):
		isCharging = true
	if Input.is_action_just_released("left_mouse"):
		isCharging = false
		isAttacking = true
		left_attack()
		
		
	if isCharging:
			attackForce += 5 * delta
			print(attackForce)
	if isAttacking and side == -1:
		anim.play("attack_up_to_right")
		if anim.is_playing():
			collision.disabled = false
	if isAttacking and side == 1:
		anim.play("attack_right_to_up")
		if anim.is_playing():
			collision.disabled = false
		#sword.rotate(attackForce * delta)
	
	if !isAttacking:
		collision.disabled = true

func load_weapon():
	atk_damage = weapon.atk_damage
	knockback_force = weapon.knockback_force
	scale = weapon.scale
	#scale.x = weapon.size
func damage():
	pass

func _on_hitbox_body_entered(body):
	if body.has_method("take_damage"):
		var attack = Attack.new()
		attack.attack_damage = atk_damage
		attack.knockback_force = knockback_force
		body.take_damage(attack)
		print("oi")

func left_attack():
	side = -side
	
	await get_tree().create_timer(attackTime).timeout
	isAttacking = false
	attackForce = 5.5
	
func animate(attack_direction: Vector2, direction: Vector2) -> void:
	look_at(direction)
	print(direction)
