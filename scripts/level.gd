extends Node2D

@export var next_level: PackedScene = null

@onready var start = $Start
@onready var exit = $Exit
@onready var death_zone = $Deathzone
@onready var player = $Player

func _ready():
	player.position = start.get_spawn_pos()
		
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.connect("touched_player", _on_trap_touched_player)
		
	exit.body_entered.connect(_on_exit_body_entered)
	death_zone.body_entered.connect(_on_deathzone_body_entered)


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
	player.active = true;

func _on_exit_body_entered(body):
	if body is Player:
		print("Player entered exit, exiting")
		exit.animate()
		player.active = false
			
		await get_tree().create_timer(1.5).timeout
		if next_level != null:
			get_tree().change_scene_to_packed(next_level)
		else:
			print("next level not selected, unable to get next scene")
			reset_player()
	else:
		print("body entered exit that is not player")
