extends Node2D

@export var object_name: String = "Objeto"
@export var interaction_text: Array[String] = [" me has encontrado"]
@onready var visual: Sprite2D = $Visual
@export var interaction_mode : String = "normal"

@export var is_collectible: bool = false
@export var item_id: String =""
@export var item_name: String = ""
@export var amount : int = 1
@export var already_used : bool = false

@export var toggled_atlas_region: Rect2 = Rect2(0,0,16,16)
@export var toggled_interaction_text: Array[String] = [" me has encontrado"]



var player_in_range : bool = false

@export var atlas_region: Rect2 = Rect2(0,0,16,16)
@export var atlas_texture: Texture2D

var is_toggled: bool = false

func _ready() -> void:
	setup_visual_from_atlas()

func setup_visual_from_atlas() -> void:
	if atlas_texture == null:
		return
	var region_texture:= AtlasTexture.new()
	region_texture.atlas = atlas_texture
	if is_toggled:
		region_texture.region = toggled_atlas_region
		
	else:
		region_texture.region = atlas_region
	visual.texture = region_texture
	
	

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
		
		
func interact() -> Dictionary:
	match interaction_mode:
		"pickup":
			return handle_pickup()
		"toggle":
			return handle_toggle()
		_:
			return handle_normal()
			

func handle_normal() -> Dictionary:
	return {
		"name": object_name,
		"text": interaction_text
		
	}

func handle_pickup() -> Dictionary:
	if is_collectible and item_id != "" and item_name != "":
		InventoryManager.add_item(item_id,item_name, amount)
		
	var result := {
		"name": object_name,
		"text": interaction_text
		
		
	}
	queue_free()
	return result
	
func handle_toggle() -> Dictionary:
	if already_used:
		if toggled_interaction_text.size() > 0:
			return{
				"name": object_name,
				"text": toggled_interaction_text
			}
		return {
		"name": object_name,
		"text": interaction_text
		
	}
	
	if is_collectible and item_id != "" and item_name != "":
		InventoryManager.add_item(item_id,item_name, amount)
		
	already_used = true
	is_toggled = true
	setup_visual_from_atlas()
	return {
		"name": object_name,
		"text": interaction_text
		
	}
