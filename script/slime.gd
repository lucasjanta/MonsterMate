extends CharacterBody2D

@export var enemyRes : enemyResource

var speed : int
var health : int
var attack_dmg : int
var dead
var player_in_area = false
var player

var slime_loot = preload("res://scenes/slime_collectable.tscn")

func _ready():
	speed = enemyRes.speed
	health = enemyRes.health
	attack_dmg = enemyRes.attack_damage
	dead = false
	
func _physics_process(delta):
	if !dead:
		$detection_area/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position - position) / speed
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")
	if dead:
		$detection_area/CollisionShape2D.disabled = true
		

func _on_detection_area_body_entered(body):
	if body is Player:
		player_in_area = true
		player = body


func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
		#player = body

func take_damage(attack: Attack):
	health -= attack.attack_damage
	if health <= 0 and !dead:
		death()
	velocity = (global_position - attack.attack_position).normalized()*attack.knockback_force
		
func death():
	dead = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1.0).timeout
	drop_item()
	queue_free()
	
func drop_item():
	var dropped_item = slime_loot.instantiate()
	dropped_item.global_position = global_position
	get_parent().add_child(dropped_item)
#	

# EU CRIEI O DANO NO PLAYER AQUI
func _on_hitbox_body_entered(body):
	if body is Player:
		damage_player(body)
		body.position.x = body.position.x - 25
	
func damage_player(player):
	player.health -= attack_dmg
	pass
