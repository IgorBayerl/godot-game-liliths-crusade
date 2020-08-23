extends KinematicBody2D

export var SPEED = 300
export var GRAVITY = 3000
export var JUMP_FORCE = -1000


var gunsArray = [ 1 , -1 , -1 , -1 , -1 ]



const NORMAL = Vector2(0, -1)

var LOOKING_DIRECTION = Vector2( 1 , 0 )

var motion = Vector2()
var direction = Vector2()
var is_dashing = false
var can_dash = true

func _physics_process(delta: float) -> void:
	_direction_move(delta)
	animations_set()
	if Input.is_action_just_pressed("interact"):
		$Camera2D.shake = true
		yield(get_tree().create_timer(0.2), "timeout")
		$Camera2D.shake = false
	
	
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
		GRAVITY = 5000
	else:
		GRAVITY = 3000
		
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
		this_ghost.texture = $SPRITES/body.frames.get_frame($SPRITES/body.animation, $SPRITES/body.frame)
	
func animations_set():
	var dir = direction
	if direction.x < 0:
		dir.x = dir.x * -1
	if dir.x == 0 and LOOKING_DIRECTION.x != 0:
		dir.x = 1
	
	if  direction.x != 0 and is_on_floor():
		$SPRITES/body.play("RUNNING")
	else :
		$SPRITES/body.play("IDLE")
		
	$SPRITES/Head.rotation = -dir.angle()
	$SPRITES.scale.x = LOOKING_DIRECTION.x

