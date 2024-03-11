extends Node2D

@export var weapon : Weapons
var atk_damage : float
var knockback_force : float
var bow_ready = true
var isCharging = false
const arrow: PackedScene = preload("res://weapons/bow/wood_arrow.tscn")

func _process(delta):
	if Input.is_action_just_pressed("left_mouse"):
		print("clicou ataque")
		left_attack()

func animate(attack_direction: Vector2, direction: Vector2) -> void:
	look_at(direction)
	$Marker2D.look_at(direction)

func left_attack():
	if bow_ready:
		var arrow_instance = arrow.instantiate()
		arrow_instance.global_position = global_position + Vector2 (4, 0)
		add_child(arrow_instance)
	bow_ready = false
	await get_tree().create_timer(0.4).timeout
	bow_ready = true
