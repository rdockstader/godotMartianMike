extends CharacterBody2D
class_name Player

@export var gravity = 400
@export var max_fall_speed = 1000
@export var move_speed = 125
@export var jump = 200

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	if is_on_floor()==false:
		velocity.y += gravity * delta
		if(velocity.y > max_fall_speed):
			velocity.y = max_fall_speed
	elif Input.is_action_just_pressed("jump"):
		velocity.y += -jump
	
	var direction = Input.get_axis("move_left", "move_right")	
	velocity.x = direction * move_speed
	
	move_and_slide()
	
	process_animations()

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
