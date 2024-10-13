
extends CharacterBody2D
@onready var timer: Timer = $Timer

var directionSide=0;
var dashing=false;
var storeTempVelocity=0;
const SPEED = 120.0
const JUMP_VELOCITY = -250.0
var DASHMAG=100;
var XcustomVelocity=0;


func _physics_process(delta: float) -> void:
	# ADD X VELOCITY
	velocity.x = XcustomVelocity;
	
	# If grounded, be on floor
	if is_on_floor():
		XcustomVelocity=0;
	
	# Add the gravity. if dashing, add a little less. 
	if not is_on_floor():
		if dashing==false:
			velocity += get_gravity() * delta
		else:
			velocity +=get_gravity()/5 * delta;
			


	#DASH TIME!!!!
	if Input.is_action_just_pressed("ui_text_caret_left"):
		dashing=!dashing;
		timer.start();
		

	#if dashing==true:
		
		


	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and dashing==false:
		if direction <0:
			directionSide=1;
		else:
			directionSide=0;
			
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_timer_timeout() -> void:
	dashing=false;
	velocity.y=storeTempVelocity;
	XcustomVelocity=SPEED/6;
