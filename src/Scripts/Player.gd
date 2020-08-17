extends KinematicBody2D

export var SPEED = 300
export var GRAVITY = 50
export var JUMP_FORCE = -300

const NORMAL = Vector2(0, -1)

var motion = Vector2()
var direction = Vector2()


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
		
		
	if Input.is_action_pressed("jump") and _pode_pular():
		var gravidade_save = GRAVITY
		if Input.is_action_pressed("jump"):
			motion.y = JUMP_FORCE
		
		
	motion = move_and_slide(motion  , NORMAL)
#	print(direction)
	
func _pode_pular() -> bool:
	if is_on_floor():
		return true
	else:
		return false
