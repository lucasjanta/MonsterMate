extends Node2D

@export var weapon : Weapons
var atk_damage : float
var knockback_force : float
var side = 1
var quarenta_cinco_graus = 0.7875
var noventa_graus = quarenta_cinco_graus * 2
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	load_weapon()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left_mouse"):
		left_attack()
	
	

func load_weapon():
	atk_damage = weapon.atk_damage
	knockback_force = weapon.knockback_force
	sprite.texture = weapon.weapon_image
	scale = weapon.scale
	#scale.x = weapon.size
func damage():
	pass
	
	


func _on_hitbox_area_entered(area):
	if area.has_method("take_damage"):
		print("oi")


func _on_hitbox_body_entered(body):
	if body.has_method("take_damage"):
		var attack = Attack.new()
		attack.attack_damage = atk_damage
		attack.knockback_force = knockback_force
		body.take_damage(attack)
		print("oi")

func left_attack():
	
	if side > 0:
		anim.play("attack_up_to_right")
	if side < 0:
		anim.play("attack_right_to_left")
	side = side * -1
