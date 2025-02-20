extends Node2D

signal touched_player


func _on_area_2d_body_entered(body):
	if body is Player:
		print("burger touched player")
		touched_player.emit()
		queue_free()
