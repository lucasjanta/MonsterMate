extends CharacterBody2D

@export var enemyRes : enemyResource
@export var idle_node : Node
@export var walk_node : Node

var speed : int
var health : int
var attack_dmg : int
var dead
var player_in_area = false
var player
var initial_pos
@onready var fsm = $FSM

func _ready():
	speed = enemyRes.speed
	health = enemyRes.health
	attack_dmg = enemyRes.attack_damage
	dead = false
	initial_pos = position
	
func _physics_process(delta):
	if !dead:
		$detection_area/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position - position) / speed
			if position.x < initial_pos.x:
				$AnimatedSprite2D.play("walk_left")
				initial_pos = position
			if position.x > initial_pos.x:
				$AnimatedSprite2D.play("walk_right")
				initial_pos = position
		else:
			fsm.change_state(idle_node, "Idle")
	if dead:
		$detection_area/CollisionShape2D.disabled = true



func _on_detection_area_body_entered(body):
	if body is Player:
		player_in_area = true
		player = body

func _on_detection_area_body_exited(body):
	if body is Player:
		player_in_area = false
