extends Control

var guns : Dictionary
var slot = preload("res://src/Actors/Gun_inventory.tscn")
var is_on_focus = false
var inventory_controller : Node
export(String) var type

var selected_gun : String

func _ready() -> void:
	guns = JsonData.item_data[type]
	inventory_controller = get_parent().get_parent().get_parent().get_parent()
	
	for i in guns:
		if guns[i].selected == true:
			selected_gun = i
			print("The guns selected is : ", i)
		var item = slot.instance()
		$GunSlideBar.add_child(item)	
		print(i)
		


func _unhandled_input(event: InputEvent) -> void:
	
	if is_on_focus:
		
		inventory_controller.ammo = guns.size()
		if event.is_action_pressed("ui_right"):
			print("right ", self.type)
		if event.is_action_pressed("ui_left"):
			print("left ", self.type)



func _on_VBoxGunsList_focus_entered() -> void:
	is_on_focus = true
	modulate.r = 255
	modulate.g = 255
	modulate.b = 255
#	inventory_controller.ammo = guns.size()


func _on_VBoxGunsList_focus_exited() -> void:
	is_on_focus = false
	modulate.r = 0
	modulate.g = 0
	modulate.b = 0
