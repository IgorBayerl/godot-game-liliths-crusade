extends Control

onready var health_over = $HealthOver
onready var health_under = $HealthUnder
onready var update_tween = $UpdateTween

var health = 100



func _on_health_updated(health, amount):
	health_over.value = health
	update_tween.interpolate_property(health_under, "value", health_under.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	update_tween.start()
	
func _on_max_health_updated(max_health):
	health_over.max_value = max_health
	health_under.max_value = max_health


#func _process(delta: float) -> void:
#	if Input.is_action_just_pressed("interact"):
#		health = health - 15
#		_on_health_updated(health,0)

func _ready() -> void:
	_on_health_updated(health,0)
#	health = get_parent().get_parent().get_parent().get_node("Player").health
	
func take_damage(damage):
		health = health - damage
		_on_health_updated(health,0)
