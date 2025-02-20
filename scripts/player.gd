extends CharacterBody2D
class_name Player

@export var gravity = 400
@export var max_fall_speed = 1000
@export var move_speed = 125
@export var jump = 200
@export var boost = 100
@export var boost_lost_per_usage =10

@onready var animated_sprite = $AnimatedSprite2D

var active = true
var boost_amount = 0


func _physics_process(delta):
	if is_on_floor()==false:
		velocity.y += gravity * delta
		if(velocity.y > max_fall_speed):
			velocity.y = max_fall_speed
			
	var direction = 0
	if active == true:
		process_jump()
		
		direction = Input.get_axis("move_left", "move_right")	
		
	velocity.x = direction * move_speed		
	move_and_slide()
	
	process_animations()
	
func process_jump():
	if Input.is_action_just_pressed("jump") && is_on_floor():
			var jump_amount = jump
			if Input.is_action_pressed("boost") && boost_amount > 0:
				print("boosted")
				jump_amount += boost
				boost_amount -= boost_lost_per_usage
				if(boost_amount < 0):
					boost_amount = 0
			velocity.y += -jump_amount
			AudioPlayer.play_sfx("jump")

func process_animations():
	if velocity.x == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")


	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false
		
	if(velocity.y > 0):
		animated_sprite.play("fall")
	elif(velocity.y < 0):
		animated_sprite.play("jump")
		
func increase_boost(value: int):
	boost_amount += value;
