extends StateMachine

func _ready() -> void:
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("atack")
	add_state("air_atack")
	add_state("stun")
	add_state("wall_slide")
	add_state("crouch")
	add_state("rolling")
	call_deferred("set_state", states.idle)
	
func _input(event):
	if[states.idle, states.run ].has(state):
		#JUMP
		if event.is_action_pressed("jump"):
			if not Input.is_action_pressed("move_DOWN"):
				parent.velocity.y = parent.max_jump_velocity
				parent.is_jumping = true
			elif Input.is_action_pressed("move_DOWN"):
				parent.position.y += 1
		if event.is_action_pressed("ctrl"):
			parent.is_crouched = true
		if event.is_action_pressed("interact"):
			parent.is_atacking = true
				
		#ROLL / #ATACK
		if state != states.rolling:
			if event.is_action_pressed("hability"):
				parent.is_rolling = true
	elif event.is_action_released("ctrl"):
			parent.is_crouched = false	
			
	elif state == states.wall_slide:
		if event.is_action_pressed("jump"):
			parent._wall_jump()
			set_state(states.jump)
	if[states.fall, states.jump ].has(state) and parent.have_double_jump:
		if event.is_action_pressed("jump") and parent.jump_count == 0:
			parent.velocity.y = parent.double_jump_velocity
			parent.jump_count = 1
			parent.is_jumping = true
	if state == states.jump:
		if event.is_action_released("jump") and parent.velocity.y < parent.min_jump_velocity:
			parent.velocity.y = parent. min_jump_velocity
	
	

func _state_logic(delta):
	parent._update_lebel_state(state , previous_state)
	parent._turning_on_skills()
	if !parent.is_dead and !parent.in_menu == true:
		parent._set_head_direction()
		if state != states.rolling:
			parent._update_move_direction()
		parent._update_wall_direction()
		if state != states.wall_slide:
			if ![states.rolling, states.atack, states.stun ].has(state):
				if !parent.wal_jumping == true:
					if !parent.is_crouched:
						parent._handle_move_input()
					parent._update_sprite_direction()
		if state == states.wall_slide:
			parent._cap_gravity_wall_slide()
			parent._handle_wall_slide_sticking()
		parent._apply_movement()
		if state == states.rolling:
			parent._roll()
	parent._update_effect_animation()
	parent._apply_gravity(delta)

func _get_transition(delta):
	match state:
		states.idle:
			if parent.is_stuned:
				return states.stun
			if parent.is_crouched:
				return states.crouch
			if parent.is_atacking:
				return states.atack
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.is_rolling:
				return states.rolling
			elif !parent.is_rolling:
				if parent.velocity.x != 0:
					return states.run
		states.run:
			if parent.is_stuned:
				return states.stun
			if parent.is_crouched:
				return states.crouch
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.is_rolling:
				return states.rolling
			elif !parent.is_rolling:
				if parent.velocity.x == 0:
					return states.idle
		states.jump:
			if parent.is_stuned:
				return states.stun
			if parent.wall_direction != 0 and parent.have_wall_jump:
				return states.wall_slide
			elif parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
		states.fall:
			if parent.is_stuned:
				return states.stun
			if parent.wall_direction != 0 and parent.have_wall_jump:
				return states.wall_slide
			elif parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0 :
				return states.jump
		states.wall_slide:
			if parent.is_stuned:
				return states.stun
			if parent.is_on_floor():
				return states.idle
			elif parent.wall_direction == 0:
				return states.fall
		states.rolling:
			if !parent.is_rolling:
				if parent.is_on_floor():
					if parent.is_crouched:
						return states.crouch
					if parent.velocity.x != 0:
						return states.run
					elif parent.velocity.x == 0:
						return states.idle
				elif parent.wall_direction == 0:
					return states.fall
				elif parent.wall_direction != 0 and parent.have_wall_jump:
					return states.wall_slide
		states.stun:
			if !parent.is_stuned:
				if !parent.is_on_floor():
					if parent.velocity.y < 0:
						return states.jump
					elif parent.velocity.y > 0:
						return states.fall
				elif parent.is_rolling:
					return states.rolling
				elif !parent.is_rolling:
					if parent.velocity.x != 0:
						return states.run
					elif parent.velocity.x == 0:
						return states.idle
		states.crouch:
			if !parent.is_crouched:
				if parent.is_stuned:
					return states.stun
				if parent.is_rolling:
					return states.rolling
				elif !parent.is_rolling:
					if parent.velocity.x != 0:
						return states.run
					elif parent.velocity.x == 0:
						return states.idle
		states.atack:
			if !parent.is_atacking:
				return states.idle
	return null

func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			print('idle')
			parent.jump_count = 0
			parent.anim_player.play("Idle")
		states.run:
			print('run')
			parent.jump_count = 0
			parent.anim_player.play("Running")
		states.jump:
			print('jump')
			parent.anim_player.play("jump")
		states.fall:
			print('fall')
			parent.anim_player.play("fall")
		states.wall_slide:
			parent.jump_count = 0
			print('wall_slide')
			parent.anim_player.play("wall_slide")
			parent.is_wall_sliding = true
			parent.get_node("SPRITES").scale.x = -parent.wall_direction
		states.rolling:
			parent.jump_count = 0
			print('lets rolla')
			parent._rolling_direction()
		states.stun:
			print('stunned')
			parent.velocity = Vector2()
			parent.anim_effect.play("piscando")
		states.crouch:
			parent.jump_count = 0
			print('crouched')
			parent.velocity.x = 0
		states.atack:
			parent.anim_player.play("Atack1")
	
func _exit_state(old_state, new_state):
	match old_state:
		states.wall_slide:
			parent.is_wall_sliding = false
			
func _on_WallSlideSticknesTimer_timeout() -> void:
	if state == states.wall_slide:
		set_state(states.fall)
