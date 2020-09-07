extends Node

var path = "res://src/data/dataItems.json"

var default_itemData: Dictionary
#"res://src/data/dataItems.json"

var default_data = {
	"player": {
		"name": "Jamie",
		"level": 3,
		"health": 10
	},
	"option":{
		"music_volume": 0.5,
		"effects_volume": 0.5,
	},
	"levels_completed":[1,2,3]
}

var data = {}

func _ready() -> void:
	pass
	
	
func load_game():
	var file = File.new()
	
	if not file.file_exists(path):
		reset_data()
		return
	
	file.open(path, file.READ)
	
	var text = file.get_as_text()
	
	data = parse_json(text)
	
func save_game():
	var file
	
	file = File.new()
	
	file.open(path, File.WRITE)
	
	file.store_line(to_json(data))
	
	file.close()
	
func reset_data():
	data = default_data.duplicate(true)
