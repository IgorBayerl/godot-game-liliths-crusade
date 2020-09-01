extends Control

var guns : Dictionary
var guns_length : int = 0
var slot = preload("res://src/Actors/Gun_inventory.tscn")

export(String) var type

func _ready() -> void:
	guns = JsonData.item_data[type]
	
	for i in guns:
		var item = slot.instance()
		$GunSlideBar.add_child(item)
		print(i)
