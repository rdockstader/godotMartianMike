extends StaticBody2D


@onready var spawn_pos = $SpawnPosition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_spawn_pos():
	return spawn_pos.global_position
