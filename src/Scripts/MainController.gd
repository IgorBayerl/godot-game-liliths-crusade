extends Node2D


var player_GUNS_information = {
	"gun_1": {
		"unlocked" : true ,
		"selected" : false ,
		"ammo": 25,
		"full_ammo": 60
	},
	"gun_2": {
		"unlocked" : false ,
		"selected" : false ,
		"ammo": 25,
		"full_ammo": 60
	},
	"gun_3": {
		"unlocked" : false ,
		"selected" : false ,
		"ammo": 25,
		"full_ammo": 60
	}
}

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func _on_Arma_body_entered(body: Node) -> void:
	$CanvasLayer/Control/Guns_bar.addItem(5)
	$Player/Mira/Arma/Sprite.visible = true
