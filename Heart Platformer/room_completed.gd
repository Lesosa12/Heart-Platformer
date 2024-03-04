extends ColorRect

signal retry()
signal next_room()

@onready var retry_button = %RetryButton
@onready var next_level_button = %NextRoomButton


func _on_retry_button_pressed():
	retry.emit()


func _on_next_room_button_pressed():
	next_room.emit()
