extends Area2D

var vida = 3

func _process(delta: float) -> void:
	pass


func _on_AreaHitbox_area_entered(area: Area2D) -> void:
	print(area)
