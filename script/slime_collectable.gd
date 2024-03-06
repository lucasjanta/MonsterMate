extends StaticBody2D

@export var item: InvItem
var player = null

func _ready():
	await get_tree().create_timer(10).timeout
	queue_free()

func _on_interactable_area_body_entered(body):
	if body is Player:
		player = body
		player.collect(item)
		await get_tree().create_timer(0.25).timeout
		self.queue_free()


	
