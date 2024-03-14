extends State
class_name EnemyWalk

@export var sprite : AnimatedSprite2D
@export var doggo : CharacterBody2D
var initial_pos : Vector2i
var position : Vector2i
func Enter():
	initial_pos = doggo.position
	position = doggo.position
	print(initial_pos)
	#sprite.play("walk_left")
	
func Update(_delta:float):
	position = doggo.position
	if position != initial_pos:
		if doggo.player.position.x - doggo.position.x <= 30 and doggo.player.position.x - doggo.position.x >= -30:
			if position.y < initial_pos.y:
				sprite.play("walk_up")
			if position.y > initial_pos.y:
				sprite.play("walk_down")
		else:
			if position.x > initial_pos.x:
				sprite.play("walk_right")
			if position.x < initial_pos.x:
				sprite.play("walk_left")	
	initial_pos = position
	
func Exit():
	pass
	
