extends KinematicBody2D

export var NORMAL_GRAVITIY = 300
export var SMALL_JUMP_GRAVITIY = 800

export var SPEED = 300
var GRAVITY = 500
export var JUMP_FORCE = -1000



var health = 100
var is_alive = true

signal OnDeath(WhoDied)

const NORMAL = Vector2(0, -1)

var LOOKING_DIRECTION = Vector2( 1 , 0 )

var is_atacking = 0
var motion = Vector2()
var direction = Vector2()
var is_dashing = false
var can_dash = true

func _physics_process(delta: float) -> void:
	_direction_move(delta)
	animations_set()
	
	death_detection()
	
	if Input.is_action_just_pressed("Gun_4"):
		take_damage(30)
	
	
func _direction_move(delta):
	
	direction = Vector2()
#	if not is_on_floor():
	motion.y += GRAVITY* delta
	
	if Input.is_action_pressed("move_UP"):
#		motion.y = -SPEED 
		direction += Vector2(0,1)
	elif Input.is_action_pressed("move_DOWN"):
#		motion.y = SPEED 
		direction += Vector2(0,-1)
	else:
		direction += Vector2(0,0)
		
	if Input.is_action_pressed("move_RIGHT"):
		motion.x = SPEED 
		direction += Vector2(1 ,0)
		LOOKING_DIRECTION.x = 1
	elif Input.is_action_pressed("move_LEFT"):
		motion.x = -SPEED 
		direction += Vector2(-1 ,0)
		LOOKING_DIRECTION.x = -1 
	else:
		direction += Vector2(0,0)
		motion.x = 0
		
	if Input.is_action_pressed("jump"):
		if _pode_pular():
			motion.y = JUMP_FORCE
	elif motion.y < 0 :
		GRAVITY = SMALL_JUMP_GRAVITIY
	else:
		GRAVITY = NORMAL_GRAVITIY
		
	if Input.is_action_just_pressed("hability"):
		dash()
		
	motion = move_and_slide(motion  , NORMAL)
#	print(direction)
	
func _pode_pular() -> bool:
	if is_on_floor():
		return true
	else:
		return false
		
func _can_dash() -> bool:
	if is_dashing == false and can_dash == true:
		return true
	else:
		return false
		
func dash():
	if _can_dash():
		$Dash_sound.play()
		is_dashing = true
		can_dash = false
		collision_layer = 8
		collision_mask = 4  
		collision_mask = 1 
		SPEED = 1000
		$Dash.visible = false
		$Dash_Timer.start()

func _on_Timer_timeout() -> void:
	SPEED = 300
	is_dashing = false
	collision_layer = 4
	collision_mask = 2 
	collision_mask = 1 
	yield(get_tree().create_timer(0.5), "timeout")
	can_dash = true
	$Dash.visible = true

func _on_Ghost_Timer_timeout() -> void:
	if is_dashing:
		var this_ghost = preload("res://src/Actors/Efeitos/ghost.tscn").instance()
		get_parent().add_child(this_ghost)
		this_ghost.position = position + Vector2(0,20)
#		this_ghost.texture = $SPRITES/body.frames.get_frame($SPRITES/body.animation, $SPRITES/body.frame)
	
func animations_set():
	if is_atacking != 0:
		$Mira/Arma.visible = false
		$Mira.can_fire = false
	else:
		if Input.is_action_just_pressed("shoot"):
			$Mira.can_fire = true
		$Mira/Arma.visible = true
		
	
	if Input.is_action_just_pressed("interact") and is_atacking == 0 :
		is_atacking = 1
		$SPRITES/AnimationPlayer.play("Atack1")
		yield(get_tree().create_timer(0.5), "timeout")
		if is_atacking == 1:
			is_atacking = 0
	if Input.is_action_just_pressed("interact") and is_atacking == 1:
		is_atacking = 2
		$SPRITES/AnimationPlayer.play("Atack2")
		yield(get_tree().create_timer(0.6), "timeout")
		if is_atacking == 2:
			is_atacking = 0
	if Input.is_action_just_pressed("interact") and is_atacking == 2 :
		is_atacking = 1
		$SPRITES/AnimationPlayer.play("Atack1")
		yield(get_tree().create_timer(0.5), "timeout")
		if is_atacking == 1:
			is_atacking = 0
	
	
		
		
	var dir = direction
	if dir.y < 0:
		dir.y = dir.y/2
	if direction.x < 0:
		dir.x = dir.x * -1
	if dir.x == 0 and LOOKING_DIRECTION.x != 0:
		dir.x = 1
		
	
	
	if  direction.x != 0 and is_on_floor() and not is_atacking:
		$SPRITES/AnimationPlayer.play("Running")
	elif direction.x == 0 and is_on_floor() and not is_atacking:
		$SPRITES/AnimationPlayer.play("Idle")
		
	$SPRITES/Head.rotation = -dir.angle()
	$SPRITES.scale.x = LOOKING_DIRECTION.x


func _on_SwordHit_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox"):
		$Mira/Camera_position/Camera2D.shake = true
#		$Camera2D
		var damage = rand_range(30, 30)
		area.get_parent().take_damage(damage)
		print(damage)
		yield(get_tree().create_timer(0.2), "timeout")
		$Mira/Camera_position/Camera2D.shake = false
		
func take_damage(damage):
	get_parent().get_node("CanvasLayer/Control/Health Bar").take_damage(damage)
	health -= damage
	print('take_damage')
		
func death_detection():
	if health <= 0 and is_alive:
		is_alive = false
		print ("AAAAAAAAAAAAAAAAAAAAAAAAAHHHH")
		emit_signal("OnDeath",self)
