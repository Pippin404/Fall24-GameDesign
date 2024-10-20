extends Node2D
const SLOW_DOWN_MAG=.3
@onready var snd_slow_down: AudioStreamPlayer2D = $snd_SlowDown
@onready var snd_dash: AudioStreamPlayer2D = $Player/AudioStreamPlayer2D

var slowMow=1;
var slowingRate=.925

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slowMow=1;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	#SLOWING DOWN
	if slowMow<1 and slowMow!=0:
		slowMow=slowMow*slowingRate;
		if slowMow<.0005:
			print(slowMow)
			slowMow=0;
			print(slowMow)
	
	
	
	#Press slowmow to slow down
	if Input.is_action_just_pressed("SlowMo"):
		
		#TODO MAKE SLOWING DOWN YOU GO TO A STOP OVER TIME. 
		if slowMow==1:
			slowMow=SLOW_DOWN_MAG;
			snd_slow_down.play();
			#print(slowMow);
		else:
			slowMow=1;
			#print(slowMow);
		
	
	
	#Press dash to stop
	if Input.is_action_just_pressed("Dash"):
		slowMow=1;
