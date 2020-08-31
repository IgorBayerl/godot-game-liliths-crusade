extends Node2D


var selected_gun = 1

var player_GUNS_information = {
	1: {
		"unlocked" : true ,
		"selected" : false ,
		"ammo": 25,
		"ammo_type" : 1,
		"damage": 30,
		"full_ammo": 60,
		"fire_rate": 0,
		"random_rate":0.02,
		"bullet_speed": 1000,
		"automatica": false
	},
	2: {
		"unlocked" : false ,
		"selected" : false ,
		"ammo": 25,
		"ammo_type" : 1,
		"damage": 20,
		"full_ammo": 60,
		"fire_rate": 0.1,
		"random_rate":0.08,
		"bullet_speed": 1000,
		"automatica": true
	},
	3: {
		"unlocked" : false ,
		"selected" : false ,
		"ammo": 700,
		"ammo_type" : 2,
		"damage": 8,
		"full_ammo": 700,
		"fire_rate": 0.02,
		"random_rate":0.2,
		"bullet_speed": 350,
		"automatica": true
	}
}

func _ready() -> void:
	$CanvasLayer/Control/Guns_bar.setAmmo(selected_gun, player_GUNS_information[selected_gun].ammo)
	_select_gun(1)

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Gun_1"):
		if player_GUNS_information[1].unlocked == true:
			_select_gun(1)
		else:
			print("you don't have this gun yet !")
	if Input.is_action_just_pressed("Gun_2"):
		if player_GUNS_information[2].unlocked == true:
			_select_gun(2)
		else:
			print("you don't have this gun yet !")
	if Input.is_action_just_pressed("Gun_3"):
		if player_GUNS_information[3].unlocked == true:
			_select_gun(3)
		else:
			print("you don't have this gun yet !")



func _on_GetItem_area_entered(area: Area2D) -> void:
	if area.is_in_group("Guns"):
		var quantidade = area.ammount
		var gun = area.type
		if player_GUNS_information[gun].unlocked == false:
			player_GUNS_information[gun].unlocked = true
			$CanvasLayer/Control/Guns_bar.addItem(quantidade)
			print("agaragun bitch")
		else:
			var total = player_GUNS_information[gun].ammo + quantidade
			player_GUNS_information[gun].ammo += quantidade
			$CanvasLayer/Control/Guns_bar.setAmmo(gun, total)
			print("more ammo")


func _select_gun(gun):
	selected_gun = gun
	$CanvasLayer/Control/Guns_bar.selectGun(gun)
	var gun_selected = player_GUNS_information[gun]
	$Player/Mira/Arma/GunSprite.set_frame(gun-1)
	$Player/Mira.damage = gun_selected.damage
	$Player/Mira.random_rate = gun_selected.random_rate
	$Player/Mira.bullet_speed = gun_selected.bullet_speed
	$Player/Mira.automatica = gun_selected.automatica
	$Player/Mira.fire_rate = gun_selected.fire_rate


func atirando():
	player_GUNS_information[selected_gun].ammo -= 1
	$CanvasLayer/Control/Guns_bar.setAmmo(selected_gun, player_GUNS_information[selected_gun].ammo)
	





