extends CharacterBody2D
@onready var timer: Timer = $Timer
@onready var dash_snd: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var jump_height_timer: Timer = $jumpHeightTimer
@onready var SlowDownController: Node2D = $"../SlowDownCntrl"

const sprP1Dash = preload("res://Sprites/sprP1Dash.png")
const sprP1Idle = preload("res://Sprites/sprP1.png")
#Jumping
const JUMP_VELOCITY = 250.0
const JUMP_ACCELLERATION_MAG=50
#Dashing
const DASH_MULTIPLER=2.5;
#Running
const MAX_SPEED = 150.0
const DEFUALT_ACCELERATION=30;
const ACCELERATION_MAG=6;
#--------------------------------------------------------------|
#Jumping
var Jump_Accelleration=JUMP_ACCELLERATION_MAG
#Running
var Accelleration=DEFUALT_ACCELERATION;
var facing=0;
#Dashing
var dashing = false;
var dashesLeft=1;
#Slowmo 
var slow_down=1;
#--------------------------------------------------------------|
func _physics_process(delta: float) -> void:	
	
	slow_down=SlowDownController.slowMow;
	
	
	
	# Dash here!
	if dashing:
		#print("dashing!")
		if facing==0:
			velocity.x = 1 * MAX_SPEED * DASH_MULTIPLER 
		else:
			velocity.x = -1 * MAX_SPEED * DASH_MULTIPLER
	
	# Add the gravity. DASH SPECIFIC
	# TODO HANDLE DASHING HERE
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		dashesLeft=1;


	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		jump_height_timer.start();
		velocity.y =JUMP_VELOCITY*-1




	#START DASH!
	if Input.is_action_just_pressed("Dash"):
		if dashesLeft>=1:
			dash_snd.play();
			dashing=true;
			velocity.y+=-100;
			sprite_2d.texture= sprP1Dash;
			dashesLeft-=1;
			timer.start();


	if !dashing:
		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("MoveLeft", "moveRight")
		if direction <0:
			facing=1;
			sprite_2d.flip_h=false;
		if direction==1:
			sprite_2d.flip_h=true;
			facing=0;
		
		if direction:
				velocity.x = direction * Accelleration
				if Accelleration<=MAX_SPEED:
					Accelleration+=ACCELERATION_MAG;
				#else:
					#dash_snd.play();
		else:
			#Deceleration
			Accelleration=DEFUALT_ACCELERATION;
			velocity.x = move_toward(velocity.x, 0, MAX_SPEED/5)

	move_and_slide()

# END DASH
func _on_timer_timeout() -> void:
	dashing=false;
	sprite_2d.texture=sprP1Idle

#Varible Jump Height
func _on_jump_height_timer_timeout() -> void:
	if !Input.is_action_pressed("Jump"):
		#print("Small jump");
		if velocity.y<0:
			velocity.y=0;
	#else:
		#print("High Jump");
		#dash_snd.play();
