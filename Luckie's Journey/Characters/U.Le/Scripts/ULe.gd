extends KinematicBody2D

onready var anim = $AnimatedSprite 
onready var target = get_node(target_path)

export var target_path = NodePath()
export var follow_offset = 100.0
export var max_speed = 250.0

const ARRIVE_THRESHOLD = 3.0

var directionFacing = Vector2() #Checks which direction the player is facing
var speed = 250.0 #Player's Speed
var vel = Vector2.ZERO#Checks how fast the player is moving
var knockback = Vector2.ZERO

func _physics_process(delta: float) -> void:
	directionFacing = Vector2()
	
	# Movement Inputs
	if Input.is_action_pressed("ui_left"):

		directionFacing = Vector2(-1,0)
	
	if Input.is_action_pressed("ui_right"):
		directionFacing = Vector2(1,0)
	
	if Input.is_action_pressed("ui_up"):
		directionFacing = Vector2(0,-1)
	
	if Input.is_action_pressed("ui_down"):
		directionFacing = Vector2(0,1)
	
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
	
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	animations()

func _on_Knockbox_area_entered(area):
	knockback = Vector2.LEFT * 400


# Plays one of the animations for Luckie depending on the direction he's facing or if he's moving
func animations ():
	
	if directionFacing.x == 1:
		play_animation("MoveRight")
		
	elif directionFacing.x == -1:
		play_animation("MoveLeft")
		
	elif directionFacing.y == 1:
		play_animation("MoveDown")
		
	elif directionFacing.y == -1:
		play_animation("MoveUp")
		
		
	
func play_animation (anim_name):
	
	if anim.animation != anim_name:
		anim.play(anim_name)

	pass
