extends Area2D


onready var TweenNode = get_node("Tween")
var subindo = false

var tempo = 2

func _ready() -> void:
	_sobe()

func _sobe():
	TweenNode.interpolate_property(self, "position", position , position+ Vector2(0, -5) , tempo, Tween.TRANS_QUAD, Tween.EASE_OUT)
	TweenNode.start()
	yield(get_tree().create_timer(tempo), "timeout")
	_desce()
	
func _desce():
	TweenNode.interpolate_property(self, "position", position , position+ Vector2(0, 5) , tempo, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	TweenNode.start()
	yield(get_tree().create_timer(tempo), "timeout")
	_sobe()
