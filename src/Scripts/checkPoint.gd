extends Area2D


export var checkpoint_number = 1

onready var TweenNode = get_node("Tween")
onready var TweenLight = get_node("LuzPiscando")
var subindo = false
var activated = false
var tempo = 2
var tempo_piscada = 1

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
	
func _ascende():
	TweenLight.interpolate_property($Light2D, "energy", $Light2D.energy, $Light2D.energy + 1, tempo_piscada, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	TweenLight.start()
	yield(get_tree().create_timer(tempo_piscada), "timeout")
	_apaga()
	
func _apaga():
	TweenLight.interpolate_property($Light2D, "energy", $Light2D.energy, $Light2D.energy - 1, tempo_piscada, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	TweenLight.start()
	yield(get_tree().create_timer(tempo_piscada), "timeout")
	_ascende()
	
func _on_CheckPoint_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and not activated:
		activated = true
		body.checkpoint_position = position
		_ascende()
