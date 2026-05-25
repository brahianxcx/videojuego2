extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@onready var area_2d: Area2D = $Area2D
@export var dialogue_initial: Array[String] = ["Hola"]
@export var dialogue_in_progress: Array[String] = ["bueno"]
@export var dialogue_completed: Array[String] = ["muchas gracias"]
@export var dialogue_state : int = 0



@export var npc_name: String = "Vampire"
@export var sprite_frame: SpriteFrames

var player_in_range: bool = false

func _ready() -> void:
	if sprite_frame:
		animated_sprite_2d.sprite_frames = sprite_frame
		
	
	if animated_sprite_2d and animated_sprite_2d.sprite_frames.has_animation("idle_down"):
		animated_sprite_2d.play("idle_down")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.set_current_interactable(self)
		player_in_range = true
		print("ingresa")



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
		body.clear_current_interactable(self)
		print("sale")

func get_current_dialogue_lines() -> Array[String]:
	match  dialogue_state:
		0:
			return dialogue_initial
		1:
			return dialogue_in_progress
			
		2:
			return dialogue_completed
			
		_:
			return dialogue_initial
			

func interact() -> Dictionary:
	
	var lineas_a_decir = get_current_dialogue_lines()
	

	if npc_name == "Vampire1":
		var item_buscado = "Llave pajaro"
		
		
		if dialogue_state != 2 and InventoryManager.has_item(item_buscado):
			InventoryManager.remove_items(item_buscado, 1)
			dialogue_state = 2
			return {
				"name": npc_name,
				"text": dialogue_completed 
			}
	
	
	
	if dialogue_state == 0:
		dialogue_state = 1
	elif dialogue_state == 1 and npc_name != "Vampire1":
		
		dialogue_state = 0 

	return {
		"name": npc_name,
		"text": lineas_a_decir
	}
