extends Node2D

@onready var start = $Start
@onready var player = $Player

func _ready():
	player.position = start.get_spawn_pos()
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.connect("touched_player", _on_trap_touched_player)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body):
	reset_player()


func _on_trap_touched_player():
	reset_player()
	
func reset_player():
	player.position = start.get_spawn_pos()
	player.velocity = Vector2.ZERO
