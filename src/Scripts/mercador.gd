extends Sprite



func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.can_access_inventory(true)
		$AudioStreamPlayer2D.play()


func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		body.can_access_inventory(false)
