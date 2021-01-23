extends Position2D

var bullet = preload("res://src/Actors/Projeteis/Bullet.tscn")

var gunsProps = {
	'bullet_speed': 1000,
	'fire_rate': 0.3,
	'random_rate': 0.08,
	'automatica': false,
	'damage': 0,
	'shooter_point_position': Vector2( 0 , 0 )
}


var is_able_to_fire = true

var dir: = Vector2()
var can_fire = true
var horizontal_dir := -1
var looking = 1

onready var camera_position = $Camera_position

onready var parent = get_parent().get_parent().get_parent()
onready var Main_controller = get_tree().get_root().get_node("Main").get_node("MainController")
onready var ShootPoint = $Mira
#func _process(delta: float) -> void:
#	if parent.in_menu:
#		return
#	_states()
#	_try_shoot()
#	$Arma.scale.y = looking
#	$Arma.scale.x = looking
	
#	_set_poit_direction()
#	if Input.is_action_pressed("ctrl") :
#		pass

func _input(event):
	_set_gun_direction()
	if event.is_action_pressed("shoot"):
		_try_shoot()
	pass
func _try_shoot():
	if is_able_to_fire:
		if Main_controller.guns_info[str("type", Main_controller.gun_on_hand)][Main_controller.aquiped_gun_of_the_type].ammo > 0:
			if gunsProps.automatica:
				if Input.is_action_pressed("shoot") and can_fire:
					instanciate_bullet()
#					$SoundEffects/Shoot.play()
			else:
				if Input.is_action_just_pressed("shoot") and can_fire:
					instanciate_bullet()
#					$SoundEffects/Shoot.play()

func _states():
	pass
#	if parent.is_dead or parent.is_atacking or parent.is_rolling or parent.is_clibing_up:
#		is_able_to_fire = false
#		visible = false
#	else :
#		is_able_to_fire = true
#		visible = true

func get_direction() -> int:
	if parent.is_wall_sliding:
		horizontal_dir = -parent.wall_direction
		
		return horizontal_dir
	else: 
		horizontal_dir = -looking
	return horizontal_dir
	
func instanciate_bullet() ->void:
	Main_controller.atirando()
	var bullet_instance = bullet.instance()
	bullet_instance.damage = gunsProps.damage
	bullet_instance.position = ShootPoint.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees + _random_value() 
	bullet_instance.apply_impulse(Vector2(),Vector2(gunsProps.bullet_speed,0).rotated(rotation + _random_value()))
	get_tree().get_root().add_child(bullet_instance)
	can_fire = false
	yield(get_tree().create_timer(gunsProps.fire_rate), "timeout")
	can_fire = true


func _random_value()-> float:
	var _random_shoot_value = 0
	_random_shoot_value = rand_range( -gunsProps.random_rate , gunsProps.random_rate )
	return _random_shoot_value
	
func _set_gun_direction():
	dir.y = -int(Input.is_action_pressed("move_UP")) + int(Input.is_action_pressed("move_DOWN"))
	if dir.y != 0:
		dir.x = 1
	rotation = dir.angle()
	
#### OLD
#func _set_poit_direction() :
#	if get_direction() < 0 :
#		dir = Vector2(0, 0)
#	if get_direction() > 0 :
#		dir = Vector2(-1, 0)
#
#
#	dir.y = -int(Input.is_action_pressed("move_UP")) + int(Input.is_action_pressed("move_DOWN"))
#	if dir.y != 0:
#		dir.x = -int(Input.is_action_pressed("move_LEFT")) + int(Input.is_action_pressed("move_RIGHT"))
#
#
#	if !parent.is_wall_sliding and !parent.is_clibing_up and !parent.is_wall_grab :
#		if Input.is_action_pressed("move_LEFT")or Input.is_action_pressed("move_RIGHT"):
#			dir.x = -int(Input.is_action_pressed("move_LEFT")) + int(Input.is_action_pressed("move_RIGHT"))
#		if dir.x == 0 and Input.is_action_pressed("move_LEFT"):
#			dir.x = looking
#	if parent.is_wall_sliding:
#		dir.x = -parent.wall_direction
#		horizontal_dir = -parent.wall_direction
#
#	if dir.x != 0:
#		looking = dir.x
#	rotation = dir.angle()
