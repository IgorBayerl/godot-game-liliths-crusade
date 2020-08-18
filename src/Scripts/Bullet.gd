extends RigidBody2D

func _ready() -> void:
	$Timer.start()
	
func _on_Timer_timeout() -> void:
	queue_free()
	

func _on_RigidBody2D_body_entered(body: Node) -> void:
	if!body.is_in_group("Player"):
		queue_free()

