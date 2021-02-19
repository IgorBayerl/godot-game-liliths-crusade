extends Node2D

var damage = 40

func _ready():
	$AnimationPlayer.play("main")

# Mais dano
func _on_Hitbox_body_entered(body):
	if body.is_in_group("Entidade"):
		body.take_damage(damage, rotation_degrees)

# dano medio
func _on_Hitbox2_body_entered(body):
	if body.is_in_group("Entidade"):
		body.take_damage(damage -10, rotation_degrees)

#Menos dano
func _on_Hitbox3_body_entered(body):
	if body.is_in_group("Entidade"):
		body.take_damage(damage -15, rotation_degrees)
