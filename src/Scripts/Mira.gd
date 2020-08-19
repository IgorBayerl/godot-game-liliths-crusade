extends Position2D

var bullet = preload("res://src/Actors/Projeteis/Bullet.tscn")

export var bullet_speed = 1000
export var fire_rate = 0.2
export var random_rate = 0.08

var dir: = Vector2()
var can_fire = true
var horizontal_dir := -1

func _process(delta: float) -> void:
	set_direction_view()
	
	if Input.is_action_pressed("shoot") and can_fire:
		instanciate_bullet()
		$SoundEffects/Shoot.play()
		
func get_direction() -> int:
	if Input.get_action_strength("move_LEFT") :
		horizontal_dir = 1
	if Input.get_action_strength("move_RIGHT"):
		horizontal_dir = -1
	return horizontal_dir
	
func instanciate_bullet() ->void:
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees + _random_value()
	bullet_instance.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation + _random_value()))
	get_tree().get_root().add_child((bullet_instance))
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true

func _random_value()-> float:
	var _random_shoot_value = 0
	_random_shoot_value = rand_range( -random_rate , random_rate )
	return _random_shoot_value
	
func set_direction_view() -> void:
	
	if get_direction() < 0:
		dir = Vector2(0, 0)
	if get_direction() > 0:
		dir = Vector2(-1, 0)
		
	if (get_direction() > 0 
	and (Input.is_action_pressed("move_UP") or Input.is_action_pressed("move_DOWN")) 
	and !Input.is_action_pressed("move_LEFT")):
		dir = Vector2(0, 0)
	
	if Input.is_action_pressed("move_RIGHT") :
		dir += Vector2(1 , 0)
	
	if Input.is_action_pressed("move_DOWN"):
		dir.y += 1
		
	if Input.is_action_just_released("move_DOWN"):
		dir += Vector2(dir.x , 0)
		
	if Input.is_action_pressed("move_UP"):
		dir.y += -1
		
	if Input.is_action_just_released("move_UP"):
		dir += Vector2(dir.x , 0)
		
	var new_dir: = Vector2()
	
#	print( dir )
	rotation = dir.angle()
	
	
	
