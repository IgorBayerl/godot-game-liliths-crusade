extends Control

var ammo:int = 0

func _ready() -> void:
	$Background/Container/Guns/VBoxGunsList.grab_focus()
#	$Background/Container/Guns/VBoxGunsList2/ScrollContainer.get_child(0).grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	$Background/Container/Label.text = str(ammo)
