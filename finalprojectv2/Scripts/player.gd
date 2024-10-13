extends CharacterBody2D
@onready var timer: Timer = $Timer
@onready var dash_snd: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite_2d: Sprite2D = $Sprite2D
const sprP1Dash = preload("res://Sprites/sprP1Dash.png")
const sprP1Idle = preload("res://Sprites/sprP1.png")

const SPEED = 150.0
const JUMP_VELOCITY = -230.0
var facing=0;
var dashing = false;


# END DASH
func _on_timer_timeout() -> void:
	dashing=false;
	sprite_2d.texture=sprP1Idle


func _physics_process(delta: float) -> void:
	
	# Dash here!
	if dashing:
		print("dashing!")
		if facing==0:
			velocity.x = 1 * SPEED * 2
		else:
			velocity.x = -1 * SPEED * 2
	
	# Add the gravity. DASH SPECIFIC
	# TODO HANDLE DASHING HERE
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		# TODO HANDLE DASHING HERE

	#START DASH!
	if Input.is_action_just_pressed("Dash"):
			dash_snd.play();
			dashing=true;
			velocity.y+=-100;
			sprite_2d.texture= sprP1Dash;
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
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)


	move_and_slide()
