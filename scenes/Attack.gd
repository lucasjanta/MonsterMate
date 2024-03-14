extends State
class_name EnemyAttack

@export var sprite : AnimatedSprite2D
@export var doggo : CharacterBody2D
@export var hitbox : Area2D
var isAttacking : bool

func Enter():
	isAttacking = true
	if sprite.animation.match("walk_left"):
		sprite.play("attack_left")
	if sprite.animation.match("walk_up"):
		sprite.play("attack_up")
	if sprite.animation.match("walk_down"):
		sprite.play("attack_down")
	if sprite.animation.match("walk_right"):
		sprite.play("attack_right")

func Update(_delta:float):
	if isAttacking:
		doggo.position += (doggo.player.position - doggo.position) / (doggo.speed)
		if sprite.animation_finished:
			isAttacking = false
		
	
func Exit():
	pass
