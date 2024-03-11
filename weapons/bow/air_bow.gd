extends Node2D

@export var weapon : Weapons
var atk_damage : float
var knockback_force : float
var isCharging = false
const arrow: PackedScene = preload("res://weapons/bow/wood_arrow.tscn")
@onready var anim = $AnimatedSprite2D
@onready var arrow_anim = $arrow_visual/AnimationPlayer
var bow_ready = false
var bow_pulled = false

func _ready():
	await get_tree().create_timer(1).timeout
	bow_ready = true

func _process(delta):
	if Input.is_action_just_pressed("left_mouse"):
		if bow_ready == true and bow_pulled == false:
			print("clicou ataque")
			anim.play("bow_pull")
			arrow_anim.play("arrow_pull")
			bow_pulled = true
		else:
			print("coold")
	if Input.is_action_just_released("left_mouse"):
		if bow_pulled == true and bow_ready == true:
			
			anim.play("bow_release")
			arrow_anim.play("arrow_reload")
			bow_pulled = false
			left_attack()
			bow_ready = false
			print("soltou ataque")
			await get_tree().create_timer(1).timeout
			bow_ready = true
			print("pode atirar de novo")

func animate(attack_direction: Vector2, direction: Vector2) -> void:
	look_at(direction)
	$Marker2D.look_at(direction)

func left_attack():
		var arrow_instance = arrow.instantiate()
		arrow_instance.global_position = global_position + Vector2 (4, 0)
		add_child(arrow_instance)
