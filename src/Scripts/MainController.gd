extends Node2D


var selected_gun = 1

var guns_info: Dictionary

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
	_select_gun(1)

func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		$CanvasLayer/Control/Inventory.visible = !$CanvasLayer/Control/Inventory.visible


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
	selected_gun = gun
	var gun_selected = player_GUNS_information[gun]
	$Player/Mira/Arma/GunSprite.set_frame(gun-1)
	$Player/Mira.damage = gun_selected.damage
	$Player/Mira.random_rate = gun_selected.random_rate
	$Player/Mira.bullet_speed = gun_selected.bullet_speed
	$Player/Mira.automatica = gun_selected.automatica
	$Player/Mira.fire_rate = gun_selected.fire_rate


func atirando():
	player_GUNS_information[selected_gun].ammo -= 1






