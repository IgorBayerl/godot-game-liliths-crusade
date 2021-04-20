extends RigidBody2D

var explode = preload("res://src/Actors/Efeitos/colision.tscn")
var damage = 13

func _ready() -> void:
	$Timer.start()
	
func _on_Timer_timeout() -> void:
	queue_free()
	

#func _on_RigidBody2D_body_entered(body: Node) -> void:
#



func _on_Fireball_body_entered(body):
	if body.is_in_group("Entidade"):
		body.take_damage(damage, rotation_degrees)
		queue_free()
	if body.is_in_group("terrain"):
		queue_free()
