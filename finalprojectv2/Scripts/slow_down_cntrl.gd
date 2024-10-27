extends Node2D
const SLOW_DOWN_MAG=.3
@onready var snd_slow_down: AudioStreamPlayer2D = $snd_SlowDown
@onready var snd_dash: AudioStreamPlayer2D = $Player/AudioStreamPlayer2D
@onready var jump_height_timer: Timer = $jumpHeightTimer
@onready var player: CharacterBody2D = $"../Player"
@onready var slowdown_stopper_timer: Timer = $slowdown_stopper_timer
@onready var canvas_modulate: CanvasModulate = $"../CanvasModulate"

var slowMow=1;
var slowingRate=.7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas_modulate.visible=false;
	slowMow=1;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	#SLOWING DOWN
	if slowMow<1 and slowMow!=0:
		canvas_modulate.visible=true;
		slowMow=slowMow*slowingRate;
		if slowMow<.0001:
			#print(slowMow)
			slowMow=0;
			#print(slowMow)
	
	
	
	#Press slowmow to slow down
	if Input.is_action_just_pressed("SlowMo"):
		
		
		#TODO MAKE SLOWING DOWN YOU GO TO A STOP OVER TIME. 
		if slowMow==1:
			slowMow=SLOW_DOWN_MAG;
			snd_slow_down.play();
			player.slow_down_ticker=1;
			slowdown_stopper_timer.start();
			#print(slowMow);
		print(player.slow_down_ticker);
	
	
	#Press dash to stop
	if Input.is_action_just_pressed("Dash"):
		stopSlowMo();




func stopSlowMo():
	canvas_modulate.visible=false;
	player.slow_down_ticker=0;
	slowMow=1;


func _on_slowdown_stopper_timer_timeout() -> void:
	stopSlowMo();
