extends Button

export(String) var scene_to_load



func _on_MenuButton_focus_entered() -> void:
	rect_scale = Vector2(1.1,1.1)
	


func _on_MenuButton_focus_exited() -> void:
	rect_scale = Vector2(1,1)
	$click.play()
