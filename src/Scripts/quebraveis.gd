extends StaticBody2D

var health = 100

func _process(_delta: float) -> void:
	_death_detection()

func take_damage(damage,damage_direction):
	$AnimationPlayer.play("take_damage")
	health -= damage
	$damage_particle.rotation_degrees = damage_direction + 180
	$damage_particle.emitting = true
	

func _death_detection():
	if health <= 0 :
		get_parent().get_node("Player2").camera_shake(0.2)
		queue_free()
