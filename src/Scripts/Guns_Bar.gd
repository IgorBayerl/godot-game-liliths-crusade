extends Control

const ListItem = preload("res://src/Interface/gunSlot.tscn")

var listIndex = 0
var selected_gun = 0


func addItem( value ):
	var item = ListItem.instance()
	listIndex += 1
	item.get_node("Bullets").text = str(value)
	item.rect_min_size = Vector2(50,50)
	$list.add_child(item)
	
func setAmmo( gun , quantidade ):
	$list.get_child(gun-1).get_node("Bullets").text = str(quantidade)


func selectGun( value ):
	var item_list_count = $list.get_child_count()
	print(' Selected ', value)
	selected_gun = value-1
	for i in range(0, item_list_count):
		$list.get_child(i).rect_scale = Vector2(1.0,1.0)
	$list.get_child(value-1).rect_scale = Vector2(1.3,1.3)


func _ready() -> void:
	addItem(10)


func _process(delta: float) -> void:
	$list.get_child(selected_gun).rect_scale = Vector2(1.3,1.3)

