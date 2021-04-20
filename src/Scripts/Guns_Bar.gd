extends Control

const ListItem = preload("res://src/Interface/gunSlot.tscn")

var listIndex = 0
var selected_gun = 0

var normal_size = 1.0
var selected_size = 1.1

onready var label = $Panel/Label
onready var sprite = $Panel/CenterContainer/CenterContainer

onready var mainController = get_parent().get_parent().get_parent()

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	label.text = str(mainController.guns_info[str("type", mainController.gun_on_hand)][mainController.aquiped_gun_of_the_type].ammo)
	sprite.frame = mainController.guns_info[str("type", mainController.gun_on_hand)][mainController.aquiped_gun_of_the_type].gun_id-1

