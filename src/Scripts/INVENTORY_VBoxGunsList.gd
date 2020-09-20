extends Control


var guns : Dictionary
var slot = preload("res://src/Actors/Gun_inventory.tscn")


var is_on_focus = false
var inventory_controller : Node
export(String) var type

var gunsInfo

var selected_gun : String
var info_gun

#onready var mainController = get_parent().get_parent().get_parent().get_parent().mainController

func _ready() -> void:
	

	guns = JsonData.item_data[type]
	inventory_controller = get_parent().get_parent().get_parent().get_parent()
	
	for i in guns:
		if guns[i].selected == true:
			info_gun = guns[i]
			_info_to_label(guns[i])
#			print("The guns selected is : ", i)
		var item = slot.instance()
		item.get_node("CenterContainer").frame = guns[i].gun_id-1
		
		if !guns[i].unlocked:
			item.get_node("CenterContainer").modulate.r = 0
			item.get_node("CenterContainer").modulate.g = 0
			item.get_node("CenterContainer").modulate.b = 0
		
		$GunSlideBar.add_child(item)
	_select_gun(0)
	
func _info_to_label(info):
	inventory_controller.info = info


func _select_gun(direction):
	
	var temp_select_id
	var new_selected
	for i in guns:
		if guns[i].selected == true :
			temp_select_id = guns[i].id
		guns[i].selected = false
		
		$GunSlideBar.get_child(int(i)-1).get_node("focus").visible = false
	
#	var maybe_next = int(temp_select_id) + int(direction)
#	if guns[str(maybe_next)].unlocked == false:
#		maybe_next = maybe_next + int(direction)
#	if guns[str(maybe_next)].unlocked == false:
#		maybe_next = maybe_next + int(direction)
		
#	new_selected = int(temp_select_id) + int(direction)
	var maybe_new_selected = int(temp_select_id) + int(direction)
	
	if maybe_new_selected == guns.size()+1:
		maybe_new_selected = 1
	if maybe_new_selected == 0:
		maybe_new_selected = guns.size()
		
	if guns[str(maybe_new_selected)].unlocked == false:
		maybe_new_selected = maybe_new_selected + int(direction)

	if maybe_new_selected == guns.size()+1:
		maybe_new_selected = 1
	if maybe_new_selected == 0:
		maybe_new_selected = guns.size()
		
	if guns[str(maybe_new_selected)].unlocked == false:
		maybe_new_selected = maybe_new_selected + int(direction)

	new_selected = maybe_new_selected
	
	if new_selected == guns.size()+1:
		new_selected = 1
	if new_selected == 0:
		new_selected = guns.size()
	
	guns[str(new_selected)].selected = true
#	print("child count: ", $GunSlideBar.get_child(new_selected-1).name)
	info_gun = guns[str(new_selected)]
#	$GunSlideBar.get_child(new_selected-1).get_node("fundo").visible = true
#	if is_on_focus:
	$GunSlideBar.get_child(new_selected-1).get_node("focus").visible = true



func _unhandled_input(event: InputEvent) -> void:
#	if !is_on_focus:
#		_tira_focus()
	if is_on_focus:
#		_select_gun(0)
		_info_to_label(info_gun)
		if event.is_action_pressed("ui_right"):
#			print("right ", self.type)
			_select_gun(1)
		if event.is_action_pressed("ui_left"):
#			print("left ", self.type)
			_select_gun(-1)




func _on_VBoxGunsList_focus_entered() -> void:
	is_on_focus = true



func _on_VBoxGunsList_focus_exited() -> void:
	is_on_focus = false

