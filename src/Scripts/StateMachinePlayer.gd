extends StateMachine

func _ready() -> void:
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("atack")
	add_state("atack2")
	add_state("stun")
	add_state("wall_slide")
	add_state("crouch")
	add_state("rolling")
	call_deferred("set_state", states.idle)
	
func _input(event):
	if[states.idle, states.run].has(state):
		#JUMP
		if event.is_action_pressed("jump"):
			if not Input.is_action_pressed("move_DOWN"):
				parent.velocity.y = parent.max_jump_velocity
				parent.is_jumping = true
			elif Input.is_action_pressed("move_DOWN"):
				parent.position.y += 1
				
		#DASH / #ATACK
		if state != states.rolling:
			if event.is_action_pressed("interact"):
				parent._atack()
			if event.is_action_pressed("hability"):
				parent.is_dashing = true
				
	elif state == states.wall_slide:
		if event.is_action_pressed("jump"):
			parent._wall_jump()
			set_state(states.jump)
	
	if state == states.jump:
		if event.is_action_released("jump") and parent.velocity.y < parent.min_jump_velocity:
			parent.velocity.y = parent. min_jump_velocity


func _state_logic(delta):
	parent._set_head_direction()
	parent._update_move_direction()
	parent._update_wall_direction()
	if state != states.wall_slide:
		if state != states.rolling or state != states.atack:
			if !parent.wal_jumping == true:
				parent._handle_move_input()
	if state == states.wall_slide:
		parent._cap_gravity_wall_slide()
		parent._handle_wall_slide_sticking()
	parent._apply_gravity(delta)
	parent._apply_movement()

func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0:
				return states.run
			elif parent.is_atacking == true:
				return states.atack
		states.run:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x == 0:
				return states.idle
			elif parent.is_atacking == true:
				return states.atack
		states.jump:
			if parent.wall_direction != 0:
				return states.wall_slide
			elif parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
		states.fall:
			if parent.wall_direction != 0:
				return states.wall_slide
			elif parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0 :
				return states.jump
		states.wall_slide:
			if parent.is_on_floor():
				return states.idle
			elif parent.wall_direction == 0:
				return states.fall
		states.atack:
			if parent.is_atacking == false:
				if parent.atack_combo == 0:
					if parent.velocity.x == 0:
						return states.idle
					elif parent.velocity.x != 0:
						return states.run
				elif parent.atack_combo == 1:
					return states.atack2
		states.atack2:
			if parent.is_atacking == false:
				if parent.atack_combo == 0:
					if parent.velocity.x == 0:
						return states.idle
					elif parent.velocity.x != 0:
						return states.run
				elif parent.atack_combo == 2:
					return states.atack
	return null

func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			print('idle')
			parent.anim_player.play("Idle")
		states.run:
			print('run')
			parent.anim_player.play("Running")
		states.jump:
			print('jump')
			parent.anim_player.play("jump")
		states.fall:
			print('fall')
			parent.anim_player.play("fall")
		states.wall_slide:
			print('wall_slide')
			parent.anim_player.play("wall_slide")
		states.atack:
			print('atack')
			parent._atack_combo()
		states.atack2:
			print('atack2')
			parent._atack_combo()
	
func _exit_state(old_state, new_state):
	pass
	

func _on_WallSlideSticknesTimer_timeout() -> void:
	if state == states.wall_slide:
		set_state(states.fall)
