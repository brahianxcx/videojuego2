extends CharacterBody2D

@export var speed : float = 100
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var dialogue_box: Control = $"../CanvasLayer/DialogueBox"
@onready var inventory_ui: Control = $"../CanvasLayer/InventoryUI"


var last_direction: String = "down"
var current_interactable: Node = null



func _ready() -> void:
	InventoryManager.add_item("potion", "Pocion", 2)
	InventoryManager.add_item("old_key", "Llave vieja", 1)
	InventoryManager.add_item("map", "Mapa", 2)

func _physics_process(delta: float) -> void:
	
	
	
	if dialogue_box and dialogue_box.is_open:
		velocity = Vector2.ZERO
		play_idle_animation()
		return
		
	if inventory_ui and inventory_ui.is_open:
		velocity = Vector2.ZERO
		play_idle_animation()
		return
		
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	input_vector = input_vector.normalized()
	velocity = input_vector * speed
	move_and_slide()
	update_animation(input_vector)
	
func update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		play_idle_animation()
		return
	if abs(direction.x) > abs (direction.y):
		last_direction = "side"
		
		if direction.x < 0:
			animated_sprite_2d.flip_h = true
			last_direction = "left"
		else:
			animated_sprite_2d.flip_h = false
			last_direction = "right"
			
		animated_sprite_2d.play("walk_side")
		
	else:
			animated_sprite_2d.flip_h = false
			
			if direction.y > 0:
				last_direction = "down"
				animated_sprite_2d.play("walk_down")
			else:
				last_direction = "up"
				animated_sprite_2d.play("walk_up")
		
	
func play_idle_animation() -> void:
	animated_sprite_2d.flip_h = false 
	
	match last_direction:
		"up":
			animated_sprite_2d.play("idle_up")
			
		"down":
			animated_sprite_2d.play("idle_down")
			
		"right":
			animated_sprite_2d.play("idle_side")
			animated_sprite_2d.flip_h = false 
			
		"left":
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.play("idle_side")

func set_current_interactable(target: Node) -> void:
	current_interactable =  target
	
func clear_current_interactable(target: Node) -> void:
	current_interactable =  null
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		if inventory_ui:
			inventory_ui.toggle_inventory()
			
		return
	
	
	
	if event.is_action_pressed("interact"):
		if dialogue_box and dialogue_box.is_open:
			dialogue_box.next_line()
			return
		
		if current_interactable and current_interactable.has_method("interact"):
			var result = current_interactable.interact()
		
			if dialogue_box and result is Dictionary:
				dialogue_box.show_dialogue(result.get("name",""), result.get("text",[]))
			
			
			await get_tree().physics_frame 
			
			
			if inventory_ui:
				inventory_ui.refresh_inventory()
