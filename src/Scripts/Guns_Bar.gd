extends Control

const ListItem = preload("res://src/Interface/gunSlot.tscn")

var listIndex = 0



func addItem( value ):
	var item = ListItem.instance()
	listIndex += 1
	item.get_node("Bullets").text = str(value)
	item.rect_min_size = Vector2(50,50)
	$list.add_child(item)
	
func addAmmo( value ):
	print(value)
	
# rect_size 78 --> 50
	
func selectGun( value ):
	print('Selected  ', value)
	$list.get_child(value-1).rect_scale = Vector2(1.3,1.3)
#	$list.get_child(value-1).get_node("GunSprite").rect_scale = Vector2(2,2)
	$list.get_child(value-1).get_node("Bullets").text = str(222)

func _ready() -> void:
#	pass
	addItem(10)
#	for i in range(5):
#		addItem(i)
		
func _process(delta: float) -> void:
	pass


#
#func _on_Arma_body_entered(body: Node) -> void:
#	if body.get_name() == "Player":
#		addItem(15)
#
	
	
	
	
