extends Node2D


var player_GUNS_information = {
	"gun_1": {
		"unlocked" : true ,
		"selected" : false ,
		"ammo": 25,
		"full_ammo": 60,
		"fire_rate": 0.2
	},
	"gun_2": {
		"unlocked" : false ,
		"selected" : false ,
		"ammo": 25,
		"full_ammo": 60,
		"fire_rate": 0.1
	},
	"gun_3": {
		"unlocked" : false ,
		"selected" : false ,
		"ammo": 25,
		"full_ammo": 60,
		"fire_rate": 0.6
	}
}

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Gun_1"):
		if player_GUNS_information.gun_1.unlocked == true:
			
			_select_gun("gun_1")
		else:
			print("you don't have this gun !")
	if Input.is_action_just_pressed("Gun_2"):
		if player_GUNS_information.gun_2.unlocked == true:
			_select_gun("gun_2")
		else:
			print("you don't have this gun !")
	if Input.is_action_just_pressed("Gun_3"):
		if player_GUNS_information.gun_3.unlocked == true:
			_select_gun("gun_3")
		else:
			print("you don't have this gun !")
	


func _on_GetItem_area_entered(area: Area2D) -> void:
	if area.is_in_group("Guns"):
		var quantidade = area.ammount
		var type = area.type
		if player_GUNS_information[type].unlocked == false:
			player_GUNS_information[type].unlocked = true
			player_GUNS_information[type].ammo += quantidade
			$CanvasLayer/Control/Guns_bar.addItem(quantidade)
			print("unlocked a new gun")
		else:
			print("more ammo")
#			$CanvasLayer/Controld/Guns_bar.addAmmo( 10 )

func _select_gun(gun):
	$CanvasLayer/Control/Guns_bar.selectGun(gun)
	var gun_selected = player_GUNS_information[gun]
	$Player/Mira/Arma/Sprite.visible = true
	$Player/Mira.automatica = true
	$Player/Mira.fire_rate = gun_selected.fire_rate
		
		
		
		
		
