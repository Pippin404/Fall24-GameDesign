extends Node2D
@onready var player: CharacterBody2D = $"../Player"
const CAMERA_SIZE=480;
const CAMERA_HEIGHT=270;
var diff=0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#self.position.x-=480;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#LEFT SIDE SEE
	if player.position.x<=self.position.x:
		#print("LEFT SIDE");
		self.position.x-=CAMERA_SIZE;
		
	#SEE RIGHT SIDE
	if player.position.x>=self.position.x+CAMERA_SIZE:
		self.position.x+=CAMERA_SIZE;
		#print("RIGHT SIDE");
		
		
	if player.position.y<self.position.y:
		self.position.y-=270;
		
