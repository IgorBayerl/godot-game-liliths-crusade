extends Node2D

export var PingPong = true


func _ready():
	if PingPong == true:
		$AnimationPlayer.play("PingPong")
	else:
		$AnimationPlayer.play("Circuit")
	
