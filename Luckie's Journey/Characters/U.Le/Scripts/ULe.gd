extends KinematicBody2D

var vel = Vector2() #Checks how fast the player is moving
var directionFacing = Vector2() #Checks which direction the player is facing
var speed = 250 #Player's Speed
onready var anim = $AnimatedSprite 


func _process(delta):
	vel = Vector2()
	directionFacing = Vector2()
	
	# Movement Inputs
	if Input.is_action_pressed("ui_left"):
		vel.x -= 1
		directionFacing = Vector2(-1,0)
	
	if Input.is_action_pressed("ui_right"):
		vel.x += 1
		directionFacing = Vector2(1,0)
	
	if Input.is_action_pressed("ui_up"):
		vel.y -= 1
		directionFacing = Vector2(0,-1)
	
	if Input.is_action_pressed("ui_down"):
		vel.y += 1
		directionFacing = Vector2(0,1)
		
	# Prevents the player's speed from increasing when moving diagnolly
	vel = vel.normalized()
	
	# Allows the player to move
	move_and_slide(vel * speed, Vector2.ZERO)
	
	animations() #Plays the animation
	

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
