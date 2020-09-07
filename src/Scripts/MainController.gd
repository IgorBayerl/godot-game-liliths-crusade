extends Node2D


var selected_gun = 1

var guns_info: Dictionary

var gun_on_hand = 1

var gun

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
	guns_info = JsonData.item_data
	gun_on_hand = guns_info["onHand"].type
	_update_gun()

func _update_guns_inventory():
	pass
	
func _update_ammo(gun, ammo):
	pass

func _update_gun():
	var gun_on_hand_str = str("type" , gun_on_hand)
	
	print("gun_on_hand_str === " ,gun_on_hand_str
	)
	for i in guns_info[gun_on_hand_str]:
		if guns_info[gun_on_hand_str][i].selected == true:
			gun = guns_info[gun_on_hand_str][i]
			print("selected gun of the type : ", gun.id)
	_select_gun(gun)
	
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Gun_1"):
		gun_on_hand = 1
		_update_gun()
		print("Gun_1")
	if event.is_action_pressed("Gun_2"):
		gun_on_hand = 2
		_update_gun()
		print("Gun_2")
	if event.is_action_pressed("Gun_3"):
		gun_on_hand = 3
		_update_gun()
		print("Gun_3")
	if event.is_action_pressed("Gun_4"):
		gun_on_hand = 4
		_update_gun()
		print("Gun_4")
	
	
	if event.is_action_pressed("inventory"):
		var inventory = $CanvasLayer/Control/Inventory
		inventory.visible = !inventory.visible
		inventory.get_node("Background/Container/Guns/VBoxGunsList").grab_focus()

func _on_GetItem_area_entered(area: Area2D) -> void:
	if area.is_in_group("Guns"):
		var quantidade = area.ammount
		var gun = area.type
		if player_GUNS_information[gun].unlocked == false:
			player_GUNS_information[gun].unlocked = true
			print("agaragun bitch")
		else:
			var total = player_GUNS_information[gun].ammo + quantidade
			player_GUNS_information[gun].ammo += quantidade
			print("more ammo")


func _select_gun(gun):
	$Player/Mira/Arma/GunSprite.set_frame(gun.id-1)
	$Player/Mira.damage = gun.damage
	$Player/Mira.random_rate = gun.random_rate
	$Player/Mira.bullet_speed = gun.bullet_speed
	$Player/Mira.automatica = gun.automatica
	$Player/Mira.fire_rate = gun.fire_rate


func atirando():
	player_GUNS_information[selected_gun].ammo -= 1






