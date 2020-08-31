extends Sprite


func _ready() -> void:
	print('explosion')
	$AnimationPlayer.play("Explosion")

