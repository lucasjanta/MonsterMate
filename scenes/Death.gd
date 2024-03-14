extends State
class_name EnemyDeath

@export var sprite : AnimatedSprite2D
@export var doggo : CharacterBody2D

func Enter():
	if sprite.animation.match("walk_left"):
		sprite.play("death_left")
	if sprite.animation.match("walk_up"):
		sprite.play("death_up")
	if sprite.animation.match("walk_down"):
		sprite.play("death_down")
	if sprite.animation.match("walk_right"):
		sprite.play("death_right")
	
func Update(_delta:float):
	pass
	
func Exit():
	pass
