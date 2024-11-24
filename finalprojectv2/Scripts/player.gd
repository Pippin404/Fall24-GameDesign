extends CharacterBody2D
@onready var dash_timer: Timer = $dash_timer
@onready var dash_snd: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var jump_height_timer: Timer = $jumpHeightTimer
@onready var SlowDownController: Node2D = $"../SlowDownCntrl"
@onready var snd_dash: AudioStreamPlayer2D = $sounds/snd_dash
@onready var snd_jmp: AudioStreamPlayer2D = $sounds/snd_jmp
@onready var camera_control: Node2D = $"../CameraControl"
@onready var jmp_buffer_timer: Timer = $jmp_buffer_timer

var explosion_node= preload("res://Scenes/explosion_node.tscn");



@onready var animated_spr: AnimatedSprite2D = $AnimatedSprite2D
@onready var explosion_handler: Node2D = $explosionHandler


const sprP1Dash = preload("res://Sprites/sprP1Dash.png")
const sprP1Idle = preload("res://Sprites/sprP1.png")
#Jumping
const JUMP_VELOCITY = 350.0
const JUMP_ACCELLERATION_MAG=100
#Dashing
const DASH_MULTIPLER=1.5;
const DASH_VERT_BOOST=-60;
const AIR_FRICTION=5;

const BURST_VERT_MOVE=JUMP_VELOCITY+20;
const BURT_HORIZ_MOVE=JUMP_VELOCITY+20;

#Running
const MAX_SPEED = 200.0
const DEFUALT_ACCELERATION=30;
const ACCELERATION_MAG=8;
#--------------------------------------------------------------|
#Jumping
var Jump_Accelleration=JUMP_ACCELLERATION_MAG
var jumping=false;
#Running
var Accelleration=DEFUALT_ACCELERATION;
var facing=0;
#Dashing
var dashing = false;
var dashesLeft=1;
#Slowmo 
var slow_down=1;
var slow_down_ticker=0; #so 0 is normal, 1 is slowdown


var checkpointX=0;
var checkpointY=0;



#--------------------------------------------------------------|




func _physics_process(delta: float) -> void:
	var currentCheckpoint=1;
	
	
	slow_down=SlowDownController.slowMow;
	if slow_down==0:
		velocity.y=0;
	
	#if we JUST slowed down
	if slow_down_ticker==1:
		#handle vertical velocity
		if velocity.y<0:
				velocity.y=-1*(velocity.y*-1)*slow_down;
			
		
	
	# Dash here!
	if dashing:
		#print("dashing!")
		if facing==0:
			velocity.x = 1 * MAX_SPEED * DASH_MULTIPLER *slow_down
		else:
			velocity.x = -1 * MAX_SPEED * DASH_MULTIPLER *slow_down
	# Add the gravity. DASH SPECIFIC
	# TODO HANDLE DASHING HERE
	if not is_on_floor():
		#Case for NO FALLING WHILE SLOWDOWN
		if slow_down!=0:
			#JUMPING NEGATIVE
			if velocity.y <0:
				velocity += get_gravity() * delta *slow_down#1.1;
			else:
				velocity += get_gravity() * delta *slow_down*.4;
		
			
	#THIS WILL WORK FOR NOW!!!
	if is_on_floor():
		dashesLeft=1;
		jumping=false;


	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor() and slow_down!=0:
		#jmp_buffer_timer.start();
		jump();




	#START DASH!
	if Input.is_action_just_pressed("Dash"):
		if dashesLeft>=1:
			snd_dash.play();
			dashing=true;
			velocity.y=DASH_VERT_BOOST;
			spawnExplosion();
			
			#EXPLOSION NOT WORKING!
			#var sfx=explosion_handler.instantiate();
			#get_parent().add_child(sfx);
			#sfx.global_position=1;
			
			#sprite_2d.texture= sprP1Dash;
			dashesLeft-=1;
			
			if velocity.y>1: #If we are moving DOWN
				velocity.y=-JUMP_VELOCITY/4 #1/4th of a jump
			else: #Moving up. add a boost
				velocity.y+=DASH_VERT_BOOST *slow_down;
			
			dash_timer.start();

	if dashing:
			animated_spr.play("dash");
			#print("dashing!");


	if !dashing:
		# Get the input direction and handle the sprite.
		var direction := Input.get_axis("MoveLeft", "MoveRight")
		if direction <0:
			facing=1;
			animated_spr.flip_h=true;
		if direction==1:
			animated_spr.flip_h=false;
			facing=0;
		
		
		#ANIMATION ZONE!
		if jumping:
			if velocity.y<0:
				animated_spr.play("jump");
		elif is_on_floor():
			if direction:
				animated_spr.play("run");
			else:
				animated_spr.play("idle");
		else:
			animated_spr.play("fall");
		
		
		
		if direction:
				if is_on_floor():
					velocity.x = direction * Accelleration *slow_down
				else:
					velocity.x = direction * Accelleration *slow_down-AIR_FRICTION
				if Accelleration<=MAX_SPEED:
					Accelleration+=ACCELERATION_MAG *slow_down;
				#else:
					#dash_snd.play();
		else:
			#Deceleration
			Accelleration=DEFUALT_ACCELERATION;
			velocity.x = move_toward(velocity.x, 0, MAX_SPEED/5)
		
	
	move_and_slide()

# END DASH
func _on_timer_timeout() -> void:
	#sprite_2d.texture=sprP1Idle
	burst_dash();

#Varible Jump Height
func _on_jump_height_timer_timeout() -> void:
	if !Input.is_action_pressed("Jump"):
		#print("Small jump");
		if velocity.y<0:
			velocity.y=0;
	#else:
		#print("High Jump");
		#dash_snd.play();

func spawnExplosion()->void:
	#print("spawned");
	var NewExplode = explosion_node.instantiate();
	add_child(NewExplode);

func jump() -> void:
	if is_on_floor() and slow_down!=0:
		snd_jmp.play();
		jumping=true;
		jump_height_timer.start();
		if slow_down==1:
			velocity.y =-1*(JUMP_VELOCITY*slow_down);
		else:
			#SLOWDOWN JUMP MAGNITUDE
			#If the slowdown is not 0, we need a special case to make sure the slowdown jump is bigger
			velocity.y =JUMP_VELOCITY*-1*slow_down/4;



func burst_dash() -> void:
	#print("Dash end!");
	#dash_snd.play();
	#check each input and add velocity. NO SETTING VELOCITY TO 0, ALLOWS FOR DIAGONAL
	velocity.x=0;
	
	if Input.is_action_pressed("JoypadUp"):
		velocity.y=velocity.y-BURST_VERT_MOVE;
		snd_dash.play();
		#print("up");
		
	if  Input.is_action_pressed("JoypadDown"):
		velocity.y=velocity.y+BURST_VERT_MOVE/10;
		#print("down");
		
	if Input.is_action_pressed("MoveRight"):
		#velocity.y+=DASH_VERT_BOOST;#vert boost is negative
		velocity.x=velocity.x+BURT_HORIZ_MOVE;
		#print("right");
		
	if Input.is_action_pressed("MoveLeft"):
		#velocity.y+=DASH_VERT_BOOST;#vert boost is negative
		velocity.x=velocity.x-BURT_HORIZ_MOVE;
		#print("left");
	dashing=false;




func _on_ready() -> void:
	checkpointX=0;
	checkpointY=0;


func _on_jmp_buffer_timer_timeout() -> void:
	if is_on_floor() and slow_down!=0:
			jump();
			print("jmpBuffer!");
