extends Control

onready var main_controller = get_parent().get_parent().get_parent()
onready var money_label = get_node("Panel/Label")

func _ready(): 
	pass
func _unhandled_input(event):
	_update_money()
	
func _update_money():
	money_label.text = str(main_controller.player_info.money)
	
