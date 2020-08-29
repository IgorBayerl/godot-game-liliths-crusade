extends KinematicBody2D

export var tempo = 1

func _ready() -> void:
	$AnimationPlayer.play("Voando")

func _sobe():
#	TweenNode.interpolate_property(self, "position", position , position+ Vector2(0, -5) , tempo, Tween.TRANS_QUAD, Tween.EASE_OUT)
#	TweenNode.start()
#	yield(get_tree().create_timer(tempo), "timeout")
#	_desce()
	pass
func _desce():
	pass
