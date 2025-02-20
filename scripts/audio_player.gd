extends Node

var hurt = preload("res://assets/audio/hurt.wav")
var jump = preload("res://assets/audio/jump.wav")


func play_sfx(sfx_name: String):
	
	var stream = null
	if sfx_name.to_lower() == "hurt":
		stream = hurt
	elif sfx_name.to_lower() == "jump":
		stream = jump
	else:
		print(sfx_name + "is an invalid sound name")
	
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX"
	
	add_child(asp)
	
	asp.play()
	
	await asp.finished
	asp.queue_free()
	
	
