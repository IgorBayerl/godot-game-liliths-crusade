extends Position2D

var bullet = preload("res://src/Actors/Projeteis/Bullet.tscn")

var gunsProps = {
	'bullet_speed': 1000,
	'fire_rate': 0.3,
	'random_rate': 0.08,
	'automatica': false,
	'damage': 30,
	'shooter_point_position_X': 30,
	'shooter_point_position_Y': 30
}


var is_able_to_fire = true

var dir: = Vector2()
var can_fire = true
var horizontal_dir := -1
var looking = 1
var shoot_direction
var gun_on_hand_id


onready var camera_position = $Camera_position

onready var parent = get_parent().get_parent().get_parent()
onready var Main_controller = get_tree().get_root().get_node("Main").get_node("MainController")
onready var ShootPoint = $Mira
onready var sprites = $Guns/GunsSprites
onready var BFGSprite = $Guns/BFG
onready var BFGAnimation = $Guns/BFG_Animation
onready var Camera = $CameraPosition/Camera2D
onready var PlayerStructure = get_parent().get_parent()
onready var StateMachine = get_parent().get_parent().get_parent().get_node("StateMachine")


#func _process(delta: float) -> void:
#	if Input.is_action_pressed("shoot") and can_fire:
#		_try_shoot()



func _input(event):
	_set_gun_direction()
	if event.is_action_pressed("shoot"):
		_try_shoot()
	pass
func _try_shoot():
	if is_able_to_fire:
		if Main_controller.guns_info[str("type", Main_controller.gun_on_hand)][Main_controller.aquiped_gun_of_the_type].ammo > 0:
			if gun_on_hand_id != 8:
				if gunsProps.automatica:
					if Input.is_action_pressed("shoot") and can_fire:
						instanciate_bullet()
						$Guns/Shoot_1.play()
				else:
					if gun_on_hand_id == 3 and can_fire:
						shotgunShoot()
						
					else:
						if Input.is_action_just_pressed("shoot") and can_fire:
							instanciate_bullet()
							$Guns/Shoot_1.play()
			else:
				bfgShoot()
				
			
func _update_props(gunsPropsMainController):
	gunsProps = gunsPropsMainController
	ShootPoint.position.x = gunsProps.shooter_point_position_X
	ShootPoint.position.y = gunsProps.shooter_point_position_Y
	print(gunsProps)
	
func _states():
	pass
#	if parent.is_dead or parent.is_atacking or parent.is_rolling or parent.is_clibing_up:
#		is_able_to_fire = false
#		visible = false
#	else :
#		is_able_to_fire = true
#		visible = true

func selcted_gun(gun_id :int):
	gun_on_hand_id = gun_id
	if gun_id != 8:
		BFGSprite.visible = false
		sprites.visible = true
	else:
		BFGAnimation.play("Idle")
		sprites.visible = false
		BFGSprite.visible = true
	sprites.set_frame(gun_id)
	print(gun_id)
	
func get_direction() -> int:
	if parent.is_wall_sliding:
		horizontal_dir = -parent.wall_direction
		
		return horizontal_dir
	else: 
		horizontal_dir = -looking
	return horizontal_dir
	
func bfgShoot() -> void:
	BFGAnimation.play("Shoot")
	can_fire = false
	yield(get_tree().create_timer(gunsProps.fire_rate), "timeout")
	can_fire = true

func shotgunShoot() -> void:
	$Guns/Shoot_1.play()
	$Guns/Shoot_ShotGun.visible = true
	yield(get_tree().create_timer(0.1), "timeout")
	$Guns/Shoot_ShotGun.visible = false
	can_fire = false
	yield(get_tree().create_timer(gunsProps.fire_rate), "timeout")
	can_fire = true

func instanciate_bullet() ->void:
	Main_controller.atirando()
	var bullet_instance = bullet.instance()
	bullet_instance.damage = gunsProps.damage
	bullet_instance.position = ShootPoint.get_global_position()
#	print('Rotation ===> ',rotation_degrees)
	#GAMBIARRA DO KCT
	if PlayerStructure.scale.x > 0:
		bullet_instance.rotation_degrees = rotation_degrees + _random_value() 
	else: 
		bullet_instance.rotation_degrees = -rotation_degrees + 180 + _random_value() 
	bullet_instance.apply_impulse(Vector2(),Vector2(gunsProps.bullet_speed,0).rotated(shoot_direction + _random_value()))
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
	var inputX = -int(Input.is_action_pressed("move_LEFT")) + int(Input.is_action_pressed("move_RIGHT"))
	if inputX != 0:
		looking = inputX
		
	if inputX != 0:
		dir.x = 1
	else: 
		if dir.y != 1 and !parent.is_wall_sliding:
			dir.x = 0
		else: dir.x = 1
	var tempDir = dir
	tempDir.x = tempDir.x * PlayerStructure.scale.x
		
	rotation = dir.angle()
	shoot_direction = tempDir.angle()
#	
func camera_shake(timeout):
	Camera.shake = true
	Camera.amplitude = 10
	yield(get_tree().create_timer(timeout), "timeout")
	Camera.shake = false
	Camera.amplitude = 6

func _on_BFG_Animation_animation_finished(anim_name):
	if anim_name == 'Shoot':
#		print('TEEEEEEEEEEEEEEEEEEIIIII')
		BFGAnimation.play("Idle")
		camera_shake(1)
