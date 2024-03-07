extends Resource

class_name enemyResource

@export var texture : Texture
@export var health : int
@export var speed : int
@export var attack_damage : int
var dead

func take_damage(damage):
	health = health - damage
	if health <= 0:
		dead = true
