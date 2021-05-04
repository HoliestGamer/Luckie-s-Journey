extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

var velocity = Vector2.ZERO


enum{
	IDLE,
	WANDER,
	CHASE
}
var state = CHASE

func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			pass
		
		CHASE:
			pass
	velocity = move_and_slide(velocity)

func seek_player():
	pass


func _on_Hurtbox_area_entered(area):
	queue_free()
	
