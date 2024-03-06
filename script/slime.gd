extends CharacterBody2D


var speed = 75
var health = 100

var dead
var player_in_area = false
var player

var slime_loot = preload("res://scenes/slime_collectable.tscn")

func _ready():
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
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
		#player = body


func _on_hitbox_area_entered(area):
	var damage 
	if area.has_method("arrow_deal_damage"):
		damage = 50
		take_damage(damage)

func take_damage(damage):
	health = health - damage
	if health <= 0 and !dead:
		death()
		
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
