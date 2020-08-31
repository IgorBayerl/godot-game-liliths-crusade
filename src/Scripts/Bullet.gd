extends RigidBody2D

var explode = preload("res://src/Actors/Efeitos/colision.tscn")

func _ready() -> void:
	$Timer.start()
	
func _on_Timer_timeout() -> void:
	queue_free()
	

func _on_RigidBody2D_body_entered(body: Node) -> void:
	
	if body.is_in_group("Entidade"):
		body.take_damage(20, rotation_degrees)
		var explode_instance = explode.instance()
		explode_instance.position = self.position
		get_tree().get_root().add_child(explode_instance)
		queue_free()
