extends CharacterBody2D

@export var speed : float = 100
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var last_direction: String = "down"


func _physics_process(delta: float) -> void:
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
