extends Node2D

@export var next_room: PackedScene

var room_time = 0.0
var start_room_msec = 0.0

@onready var room_completed = $CanvasLayer/RoomCompleted
@onready var start_in = %StartIn
@onready var start_in_label = %StartInLabel
@onready var animation_player = $AnimationPlayer
@onready var room_time_label = %RoomTimeLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	if not next_room is PackedScene:
		room_completed.next_room_button.text = "Next Room"
		next_room = load("res://Rooms/Room2.tscn")
	Events.room_completed.connect(show_room_completed)
	get_tree().paused = true
	start_in.visible = true
	LevelTransistion.fade_from_black()
	animation_player.play('countdown')
	await animation_player.animation_finished
	get_tree().paused = false
	start_in.visible = false
	start_room_msec = Time.get_ticks_msec()
	

func _process(delta):
	room_time = Time.get_ticks_msec() - start_room_msec
	room_time_label.text = str(room_time / 1000.0) 

func retry():
	await LevelTransistion.fade_from_black()
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_file_path)

func go_to_next_room():
	if not next_room is PackedScene: return
	await LevelTransistion.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_room)

func show_room_completed():
	room_completed.show()
	room_completed.retry_button.grab_focus()
	get_tree().paused = true

func _on_room_completed_next_room():
	go_to_next_room()

func _on_room_completed_retry():
	retry()
