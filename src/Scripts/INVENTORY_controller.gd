extends Control

#var ammo:int = 0
#var selectedGun : String = "gun"
var info

onready var player = get_parent().get_parent().get_parent().get_node("Player")
onready var mainController = get_parent().get_parent().get_parent()


func _ready() -> void:
	$Background/Container/Guns/VBoxGunsList.grab_focus()


func _unhandled_input(event):
	if self.visible == true :
		if (event.is_action_pressed("ui_left")
		or event.is_action_pressed("ui_right")
		or event.is_action_pressed("ui_up")
		or event.is_action_pressed("ui_down")
		):
			$AudioStreamPlayer.play() 
	
	
	_set_text()
	if visible == true:
		player.in_menu = true
	else:
		player.in_menu = false

func _set_text():
	#Name
	$Background/Container/HBoxContainer/VBoxContainer/Name.text = ("Name :" + str(info.name))
	#Damage
	$Background/Container/HBoxContainer/VBoxContainer/Damage.text = ("Damage :" + str(info.damage))
	#Fire rate
	$Background/Container/HBoxContainer/VBoxContainer/FireRate.text = ("Fire Hate :" + str(info.fire_rate))
	#Ammo
	$Background/Container/HBoxContainer/VBoxContainer2/Ammo.text = ("Ammo :" + str(info.ammo))
	#Ammo type
	$Background/Container/HBoxContainer/VBoxContainer2/AmmoType.text = ("Ammo Type :" + str(info.ammo_type))
	#Max ammo
	$Background/Container/HBoxContainer/VBoxContainer2/MaxAmmo.text = ("Max Ammo :" + str(info.full_ammo))
	#Ammo
	$Background/Container/HBoxContainer/VBoxContainer3/Ammo.text = ("Bullet Speed :" + str(info.bullet_speed))
	#Ammo type
	$Background/Container/HBoxContainer/VBoxContainer3/AmmoType.text = ("Ammo Type :" + str(info.ammo_type))
	#Max ammo
	$Background/Container/HBoxContainer/VBoxContainer3/MaxAmmo.text = ("Max Ammo :" + str(info.full_ammo))

