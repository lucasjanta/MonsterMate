extends State
class_name EnemyDeath

@export var sprite : AnimatedSprite2D
@export var doggo : CharacterBody2D

func Enter():
	if sprite.animation.match("walk_left") or sprite.animation.match("attack_left") or sprite.animation.match("idle_left"):
		sprite.play("death_left")
	if sprite.animation.match("walk_up") or sprite.animation.match("attack_up") or sprite.animation.match("idle_up"):
		sprite.play("death_up")
	if sprite.animation.match("walk_down") or sprite.animation.match("attack_down") or sprite.animation.match("idle_down"):
		sprite.play("death_down")
	if sprite.animation.match("walk_right") or sprite.animation.match("attack_right") or sprite.animation.match("idle_right"):
		sprite.play("death_right")
	
func Update(_delta:float):
	if sprite.animation_finished:
		await get_tree().create_timer(1.5).timeout
		doggo.queue_free()
	pass
	
func Exit():
	pass
