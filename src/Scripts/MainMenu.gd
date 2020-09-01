extends Control

var scene_path_to_load

func _ready() -> void:
	$Menu/CenterRow/Butons/NewGameButton.grab_focus()
	for button in $Menu/CenterRow/Butons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$Fade.show()
	$Fade.fade_in()


func _on_Fade_fade_finished() -> void:
	get_tree().change_scene(scene_path_to_load)
