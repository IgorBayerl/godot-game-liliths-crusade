extends StaticBody2D

var health = 100

func _process(delta: float) -> void:
	_death_detection()

func take_damage(damage,damage_direction):
	get_parent().get_node("Player").camera_shake(0.2)
	health -= damage
	

func _death_detection():
	if health <= 0 :
		queue_free()
