extends KinematicBody2D

onready var Player = get_parent().get_node("Player")


var react_time = 400
var dir = 0
var next_dir = 0
var next_dir_time = 0
var direction: = get_direction()
var vel = 200

func _ready():
	set_process(true)

	
	vel = move_and_slide(vel)
func get_direction() -> Vector2:
	if Player.position.x < position.x and next_dir != -1:
		next_dir = -1
		next_dir_time = OS.get_ticks_msec() + react_time
		$AnimationPlayer.play("Run")
		$Aroldo.scale.x = -2.6
	elif Player.position.x > position.x and next_dir != 1:
		next_dir = 1
		next_dir_time = OS.get_ticks_msec() + react_time
		$Aroldo.scale.x = 2.6
		$AnimationPlayer.play("Run")
	elif Player.position.x == position.x and next_dir != 0:
		next_dir = 0
		next_dir_time = OS.get_ticks_msec() + react_time
		$AnimationPlayer.play("Idle")
		
		if OS.get_ticks_msec() > next_dir_time:
			dir = next_dir
		vel.x = dir * 500
	return Vector2(0,0)
	
