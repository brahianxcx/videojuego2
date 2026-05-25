extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@onready var area_2d: Area2D = $Area2D
@export var dialogue_text: String = "Hola"


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

func interact() -> Dictionary:
	return {
		"name": npc_name,
		"text": dialogue_text
	}
	
