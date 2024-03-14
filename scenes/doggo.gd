extends CharacterBody2D

@export var enemyRes : enemyResource
@export var idle_node : Node
@export var walk_node : Node
@export var death_node : Node
@export var attack_node : Node

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
			if position != initial_pos:
				pass
	if dead:
		$detection_area/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true



func _on_detection_area_body_entered(body):
	if body is Player:
		player_in_area = true
		player = body
		fsm.change_state(idle_node, "Walk")

func _on_detection_area_body_exited(body):
	if body is Player:
		player_in_area = false
		fsm.change_state(walk_node, "Idle")

func _on_attack_range_body_entered(body):
	if body is Player:
		fsm.change_state(walk_node, "Attack")
		

func _on_attack_range_body_exited(body):
	if body is Player:
		fsm.change_state(attack_node, "Walk")

func take_damage(attack: Attack):
	health -= attack.attack_damage
	if health <= 0:
		dead = true
		fsm.change_state(walk_node, "Death")
