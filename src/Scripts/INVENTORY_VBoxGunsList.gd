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
	
#	for i in guns:
#		var maybe_next = _select_next( guns , direction, new_selected, temp_select_id )
#		if guns[str(maybe_next)].unlocked == true:
#			new_selected = maybe_next
	
	new_selected = int(temp_select_id) + int(direction)
	
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



func _verifica_desbloqueio_de_arma(direction):
	var next_gun
	var temp_select_id
	
	for i in guns:
		if guns[i].selected == true :
			temp_select_id = guns[i].id
	
	for i in guns:
		var maybe_next = _select_next( guns , direction, next_gun, temp_select_id )
		if guns[str(temp_select_id)].unlocked == true:
			next_gun = maybe_next
#	while guns[str(temp_select_id)].unlocked == false:
#	for i in guns:
#		if guns[i].unlocked == true :
#			temp_select_id = guns[i].id
#
#	next_gun = int(temp_select_id) + int(direction)
	if guns[str(next_gun)].unlocked == false:
		pass

func _select_next( array , direction, next, temp ):
	for i in array:
		if array[i].unlocked == true :
			temp = array[i].id
	next = int(temp) + int(direction)
	print(next)
	
	return next
	

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

