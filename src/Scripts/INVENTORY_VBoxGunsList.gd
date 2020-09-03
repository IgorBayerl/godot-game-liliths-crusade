extends Control

var guns : Dictionary
var slot = preload("res://src/Actors/Gun_inventory.tscn")

var is_on_focus = false
var inventory_controller : Node
export(String) var type

var selected_gun : String
var info_gun

func _ready() -> void:
	guns = JsonData.item_data[type]
	inventory_controller = get_parent().get_parent().get_parent().get_parent()
	
	for i in guns:
		if guns[i].selected == true:
			info_gun = guns[i]
			_info_to_label(guns[i])
			print("The guns selected is : ", i)
		var item = slot.instance()
		item.get_child(0).frame = guns[i].gun_id-1
		$GunSlideBar.add_child(item)

func _info_to_label(info):
	inventory_controller.info = info
func _select_gun(direction):
	var temp_select_id
	var new_selected
	for i in guns:
		if guns[i].selected == true :
			temp_select_id = guns[i].id
		guns[i].selected = false
		$GunSlideBar.get_child(int(i)-1).rect_scale = Vector2(1,1)
		$GunSlideBar.get_child(int(i)-1).rect_pivot_offset.y = 0
	new_selected = int(temp_select_id) + int(direction)
	if new_selected == guns.size()+1:
		new_selected = 1
	if new_selected == 0:
		new_selected = guns.size()
	guns[str(new_selected)].selected = true
	print("child count: ", $GunSlideBar.get_child(new_selected-1).name)
	info_gun = guns[str(new_selected)]
	$GunSlideBar.get_child(new_selected-1).rect_scale = Vector2(1.1,1.1)
	$GunSlideBar.get_child(new_selected-1).rect_pivot_offset.y = 100



func _unhandled_input(event: InputEvent) -> void:
	if is_on_focus:
		_info_to_label(info_gun)
		if event.is_action_pressed("ui_right"):
			print("right ", self.type)
			_select_gun(1)
		if event.is_action_pressed("ui_left"):
			print("left ", self.type)
			_select_gun(-1)



func _on_VBoxGunsList_focus_entered() -> void:
	is_on_focus = true



func _on_VBoxGunsList_focus_exited() -> void:
	is_on_focus = false

