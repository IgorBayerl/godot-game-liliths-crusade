extends Control

onready var health_bar = $HealthBar
onready var health_under = $HealthUnder
onready var update_tween = $UpdateTween

func _on_health_updated(health, amount):
#	health_bar.value = health
	update_tween.interpolate_property(health_under, "value", health_under.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	update_tween.start()
	
func _on_max_health_updated(max_health):
	health_bar.max_value = max_health
	health_under.max_value = max_health
