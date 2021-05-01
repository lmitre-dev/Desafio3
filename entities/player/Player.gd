extends KinematicBody2D

onready var cannon = $Cannon

export (float) var ACCELERATION:float = 20.0
export (float) var H_SPEED_LIMIT:float = 600.0
export (float) var FRICTION_WEIGHT:float = 0.1
export (float) var gravity: float = 10

var velocity:Vector2 = Vector2.ZERO
var projectile_container
var jump_speed:int = 500
var floorDirection:Vector2 = Vector2.UP# Igual a Vector2(0, -1)

func initialize(projectile_container):
	self.projectile_container = projectile_container
	cannon.projectile_container = projectile_container

func get_input():
	
	# Cannon rotation
	var mouse_position:Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)
	
	# Cannon fire
	if Input.is_action_just_pressed("fire_cannon"):
		if projectile_container == null:
			projectile_container = get_parent()
			cannon.projectile_container = projectile_container
		cannon.fire()
	
	# Player movement
	var h_movement_direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
	
	# Jump movement
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y -= jump_speed
	
func notify_hit():
	print("hit")	
	
func _ready():
	add_to_group("player")
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity
	move_and_slide(velocity, floorDirection )
