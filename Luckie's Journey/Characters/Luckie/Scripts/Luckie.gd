extends KinematicBody2D

var vel = Vector2() #Checks how fast the player is moving
var directionFacing = Vector2() #Checks which direction the player is facing
var speed = 250.0 #Player's Speed
onready var anim = $AnimatedSprite 
var damage = 1
var health = 1
var counter = 0
enum{
	MOVE,
	ATTACK
}
var state = MOVE #Whether the player is in moving phase or attacking phase


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
	
	
	if Input.is_action_pressed("attack"):
		state = ATTACK
		get_node("AnimatedSprite/Area2D/HatchetCollision").disabled = false
	elif(Input.is_action_just_released("attack")):
			get_node("AnimatedSprite/Area2D/HatchetCollision").disabled = true
	animations(state) #Plays the animation
	
	if(state == ATTACK):
		state = MOVE

# Plays one of the animations for Luckie depending on the direction he's facing or if he's moving
func animations (state):
	match state:
		MOVE:
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
			
		ATTACK:
			if vel.x > 0:
				vel = Vector2.ZERO
				play_animation("AttackRight")
				
			elif vel.x < 0: 
				vel = Vector2.ZERO
				play_animation("AttackLeft")
				
			elif vel.y > 0:
				vel = Vector2.ZERO
				play_animation("AttackDown")
				
			elif vel.y < 0:
				vel = Vector2.ZERO 
				play_animation("AttackUp")

func play_animation (anim_name):
	
	if anim.animation != anim_name:
		anim.play(anim_name)

	pass

func _on_Area2D_area_entered(area):
	counter += 1
	print(counter)
	
	if counter == 20:
		get_tree().change_scene("res://Completed.tscn")
		counter = 0
	
