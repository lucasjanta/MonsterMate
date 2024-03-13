extends State
class_name EnemyWalk

@export var sprite : AnimatedSprite2D

func Enter():
	sprite.play("walk_left")
	pass
	
func Update(_delta:float):
	pass

func Exit():
	pass
	
