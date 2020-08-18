extends KinematicBody2D

export var SPEED = 300
export var GRAVITY = 50
export var JUMP_FORCE = -300

const NORMAL = Vector2(0, -1)

var motion = Vector2()
var direction = Vector2()
var is_dashing = false
var can_dash = true

func _physics_process(delta: float) -> void:
	_direction_move(delta)
	
	
func _direction_move(delta):
	
	direction = Vector2()
	motion.y += GRAVITY
	
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
	elif Input.is_action_pressed("move_LEFT"):
		motion.x = -SPEED 
		direction += Vector2(-1 ,0)
	else:
		direction += Vector2(0,0)
		motion.x = 0
		
	if Input.is_action_pressed("jump"):
		if _pode_pular():
			motion.y = JUMP_FORCE
	elif motion.y < 0 :
		GRAVITY = 120
	else:
		GRAVITY = 50
		
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
		
		is_dashing = true
		can_dash = false
		SPEED = 800
		$Dash.visible = false
		$Dash_Timer.start()

func _on_Timer_timeout() -> void:
	SPEED = 300
	is_dashing = false
	yield(get_tree().create_timer(0.5), "timeout")
	can_dash = true
	$Dash.visible = true



func _on_Ghost_Timer_timeout() -> void:
	if is_dashing:
		var this_ghost = preload("res://src/Actors/Efeitos/ghost.tscn").instance()
		get_parent().add_child(this_ghost)
		this_ghost.position = position
	
