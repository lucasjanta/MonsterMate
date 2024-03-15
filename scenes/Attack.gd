extends State
class_name EnemyAttack

@export var sprite : AnimatedSprite2D
@export var doggo : CharacterBody2D
@export var hitbox : Area2D
@export var hit_collision : CollisionShape2D

func Enter():
	hit_collision.disabled = false
	var distance_to_player = doggo.global_position.distance_to(doggo.player.global_position)
	if sprite.animation.match("walk_left"):
		sprite.play("attack_left")
		hitbox.rotation_degrees = -180
	elif sprite.animation.match("walk_up"):
		sprite.play("attack_up")
		hitbox.rotation_degrees = -90
	elif sprite.animation.match("walk_down"):
		sprite.play("attack_down")
		hitbox.rotation_degrees = 90
	elif sprite.animation.match("walk_right"):
		sprite.play("attack_right")
		hitbox.rotation_degrees = 0

func Update(_delta:float):
		if !sprite.is_playing():
			doggo.isAttacking = false
	
func Exit():
	hit_collision.disabled = true
	doggo.isAttacking = false
