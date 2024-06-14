extends Area2D

@export var jump_velocity = 300

@onready var animated_sprite = $Sprite


func _on_body_entered(body):
	if body is Player:
		animated_sprite.play("Jump")
		body.velocity.y = -jump_velocity
