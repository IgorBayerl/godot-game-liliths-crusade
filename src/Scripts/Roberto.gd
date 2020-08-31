extends KinematicBody2D

onready var TweenNode = get_node("Tween")
export var tempo = 0.25


func _ready() -> void:
	_sobe()
#	_desce()
	$AnimationPlayer.play("Voando")

func _sobe():
	TweenNode.interpolate_property(self, "position", position , position+ Vector2(0, -5) , tempo, Tween.TRANS_QUAD, Tween.EASE_OUT)
	TweenNode.start()
	yield(get_tree().create_timer(tempo), "timeout")
	_desce()
func _desce():
	TweenNode.interpolate_property(self, "position", position , position+ Vector2(0, +5) , tempo, Tween.TRANS_QUAD, Tween.EASE_OUT)
	TweenNode.start()
	yield(get_tree().create_timer(tempo), "timeout")
	_sobe()
	
func take_damage(damage):
	print(damage)
