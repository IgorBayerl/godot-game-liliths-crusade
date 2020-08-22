extends Area2D

onready var TweenNode = get_node("Tween")

var subindo = false
var is_picked = false

export var type = 1

func _on_Arma_body_entered(body: Node) -> void:
	if body.get_name() == "Player":
		_picked()
		
func _ready() -> void:
	_sobe()

	
func _sobe():
	if is_picked == false:
		TweenNode.interpolate_property(self, "position", position , position+ Vector2(0, -5) , 0.5, Tween.TRANS_QUAD, Tween.EASE_OUT)
		TweenNode.start()
		yield(get_tree().create_timer(0.5), "timeout")
		_desce()
	
func _desce():
	if is_picked == false:
		TweenNode.interpolate_property(self, "position", position , position+ Vector2(0, 5) , 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		TweenNode.start()
		yield(get_tree().create_timer(0.5), "timeout")
		_sobe()

func _picked():
	
	if is_picked == false:
		is_picked = true
		print("peguei")
		$Sound_Picked.play()
		TweenNode.interpolate_property(self, "position", position , position+ Vector2(0, -40) , 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
		TweenNode.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1,Tween.TRANS_SINE, Tween.EASE_OUT)
		TweenNode.start()
		yield(get_tree().create_timer(1), "timeout")
		queue_free()
