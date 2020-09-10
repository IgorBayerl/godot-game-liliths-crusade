extends ColorRect

signal fade_finished

func fade_in():
	$AnimationPlayer.play("fade_in")

func fade_out():
	$AnimationPlayer.play_backwards("fade_in")
	
	
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	emit_signal("fade_finished")
