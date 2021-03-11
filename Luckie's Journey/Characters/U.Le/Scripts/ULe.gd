extends KinematicBody2D

onready var anim = $AnimatedSprite 
onready var target = get_node(target_path)

export var target_path = NodePath()
export var follow_offset = 100.0
export var max_speed = 550.0

const ARRIVE_THRESHOLD = 3.0

var directionFacing = Vector2() #Checks which direction the player is facing
var speed = 250 #Player's Speed
var vel = Vector2.ZERO#Checks how fast the player is moving

func _physics_process(delta: float) -> void:
	if target == self:
		set_physics_process(false)
	
	var target_global_position: Vector2 = target.global_position
	var to_target: = global_position.distance_to(target_global_position)
	
	if to_target < ARRIVE_THRESHOLD:
		return
	
	vel = Steering.arrive_to(
		vel,
		global_position,
		target_global_position,
		max_speed,
		200.0,
		2.0
	)
	
	vel = move_and_slide(vel)
	animations()

# Plays one of the animations for Luckie depending on the direction he's facing or if he's moving
func animations ():
	
	if vel.x > 0:
		play_animation("MoveRight")
		
	elif vel.x < 0:
		play_animation("MoveLeft")
		
	elif vel.y > 0:
		play_animation("MoveDown")
		
	elif vel.y < 0:
		play_animation("MoveUp")
		
	elif directionFacing.x == 1:
		play_animation("IdleRight")
		
	elif directionFacing.x == -1: 
		play_animation("IdleLeft")
		
	elif directionFacing.y == 1:
		play_animation("IdleDown")
		
	elif directionFacing.y == -1: 
		play_animation("IdleUp")
		
	
func play_animation (anim_name):
	
	if anim.animation != anim_name:
		anim.play(anim_name)

	pass
