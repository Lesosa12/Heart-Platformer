extends Node2D

@export var next_level: PackedScene
@onready var level_completed = $CanvasLayer/LevelCompleted

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.level_completed.connect(show_level_completed)

func show_level_completed():
	level_completed.show()
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	if not next_level is PackedScene: return
	await LevelTransistion.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)
	LevelTransistion.fade_from_black()
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
