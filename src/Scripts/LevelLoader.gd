extends Node2D

var player_info: Dictionary
var map

func _ready():
	player_info = JsonData.player_data
	map = player_info.atual_area
	

