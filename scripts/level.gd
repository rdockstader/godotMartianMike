extends Node2D

@export var next_level: PackedScene = null
@export var level_time = 5

@onready var start = $Start
@onready var exit = $Exit
@onready var death_zone = $Deathzone
@onready var player = $Player

@onready var hud = $UILayer/HUD
@onready var ui_layer = $UILayer

var timer_node = null
var time_left

var win = false

func _ready():
	player.position = start.get_spawn_pos()
		
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.connect("touched_player", _on_trap_touched_player)
		
	exit.body_entered.connect(_on_exit_body_entered)
	death_zone.body_entered.connect(_on_deathzone_body_entered)
	
	time_left = level_time
	hud.set_time_label(time_left)
	timer_node = Timer.new()
	timer_node.name = "LevelTimer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()
	
func _on_level_timer_timeout():
	if win == false:
		time_left -= 1
		if time_left < 0:
			reset_player()
		hud.set_time_label(time_left)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body):
	reset_player()


func _on_trap_touched_player():
	AudioPlayer.play_sfx("hurt")
	reset_player()
	
func reset_player():
	player.position = start.get_spawn_pos()
	player.velocity = Vector2.ZERO
	player.active = true;
	time_left = level_time

func _on_exit_body_entered(body):
	if body is Player:
		win = true
		print("Player entered exit, exiting")
		exit.animate()
		player.active = false
		await get_tree().create_timer(1.5).timeout
		
		if next_level != null:
			get_tree().change_scene_to_packed(next_level)
		else:
			ui_layer.show_win_screen(true)
	else:
		print("body entered exit that is not player")
