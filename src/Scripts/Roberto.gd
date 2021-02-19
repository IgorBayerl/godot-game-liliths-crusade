extends KinematicBody2D

onready var TweenNode = get_node("Tween")
export var tempo = 0.25
export var health = 200

signal OnDeath(WhoDied)

func _death_detection():
	if health <= 0 :
		get_parent().get_node("Player2").camera_shake(0.2)
		queue_free()
		emit_signal("OnDeath",self)


func _process(_delta: float) -> void:
	_death_detection()

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
	
func take_damage(damage, damage_direction):
	print(damage_direction)
	health -= damage 
	$AnimationPlayer.play("taking_damage")
	yield(get_tree().create_timer(0.2), "timeout")
	$AnimationPlayer.play("Voando")
	
	
