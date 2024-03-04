extends Node2D
# uses ai
var current_room = null

func _ready():
	# Load the starting room
	change_room("res://Rooms/Room1.tscn")

func change_room(room_path):
	# Free the current room
	if current_room != null:
		current_room.queue_free()
	
	# Load the new room
	var room = load(room_path)
	current_room = room.instance()
	add_child(current_room)
