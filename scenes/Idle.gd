extends State
class_name EnemyIdle

@export var sprite : AnimatedSprite2D

func Enter():
	sprite.play("idle_left")
	pass
	
func Update(_delta:float):
	pass

func Exit():
	pass
	
