extends Node2D


var selected_gun = 1

var guns_info: Dictionary
var player_info: Dictionary


var gun_on_hand = 1

var aquiped_gun_of_the_type = "1"

var gun


func _ready() -> void:
	guns_info = JsonData.item_data
	player_info = JsonData.player_data
	gun_on_hand = guns_info["onHand"].type
	_update_gun()
	$CanvasLayer/Control/Fade.show()
	$CanvasLayer/Control/Fade.fade_out()

func _update_guns_inventory():
	pass
	
func _update_ammo(gun, ammo):
	pass

func _update_gun():
	var gun_on_hand_str = str("type" , gun_on_hand)
	
	print("gun_on_hand_str === " ,gun_on_hand_str)
	for i in guns_info[gun_on_hand_str]:
		if guns_info[gun_on_hand_str][i].selected == true:
			gun = guns_info[gun_on_hand_str][i]
			print("selected gun of the type : ", gun.gun_id)
	_select_gun(gun)

#func _process(delta: float) -> void:
#	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Gun_1"):
		gun_on_hand = 1
		_check_equiped_gun()
		_update_gun()
		print("Gun_1")
	if event.is_action_pressed("Gun_2"):
		gun_on_hand = 2
		_check_equiped_gun()
		_update_gun()
		print("Gun_2")
	if event.is_action_pressed("Gun_3"):
		gun_on_hand = 3
		_check_equiped_gun()
		_update_gun()
		print("Gun_3")
	if event.is_action_pressed("Gun_4"):
		gun_on_hand = 4
		_check_equiped_gun()
		_update_gun()
		print("Gun_4")

	if event.is_action_pressed("inventory"):
		if $Player.can_access_inventory:
			_check_equiped_gun()
			_update_gun()
			var inventory = $CanvasLayer/Control/Inventory
			inventory.visible = !inventory.visible
			inventory.get_node("Background/Container/Guns/VBoxGunsList").grab_focus()

func _on_GetItem_area_entered(area: Area2D) -> void:
	if area.is_in_group("Guns"):
		var quantidade = area.ammount
		var gun = area.type
		if guns_info[str("type", gun_on_hand)][aquiped_gun_of_the_type].unlocked == false:
			guns_info[str("type", gun_on_hand)][aquiped_gun_of_the_type].unlocked = true
			print("agaragun bitch")
#		if player_GUNS_information[gun].unlocked == false:
#			player_GUNS_information[gun].unlocked = true
		else:
			var total = guns_info[str("type", gun_on_hand)][aquiped_gun_of_the_type].ammo + quantidade
			guns_info[str("type", gun_on_hand)][aquiped_gun_of_the_type].ammo += quantidade
			print("more ammo")


func _select_gun(gun):
	$Player/Mira/Arma/GunSprite.set_frame(gun.gun_id-1)
	$Player/Mira.damage = gun.damage
	$Player/Mira.random_rate = gun.random_rate
	$Player/Mira.bullet_speed = gun.bullet_speed
	$Player/Mira.automatica = gun.automatica
	$Player/Mira.fire_rate = gun.fire_rate


func atirando():
#	player_GUNS_information[selected_gun].ammo -= 1
	guns_info[str("type", gun_on_hand)][aquiped_gun_of_the_type].ammo -= 1
	
func _check_equiped_gun():
	for i in guns_info[str("type", gun_on_hand)]:
		if guns_info[str("type", gun_on_hand)][i].selected == true:
			aquiped_gun_of_the_type = i
			print("gun selected: ", i)
		else:
			pass






