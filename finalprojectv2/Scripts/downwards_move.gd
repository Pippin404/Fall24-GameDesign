extends Node2D
@onready var camera_control: Node2D = $"../CameraControl"
@onready var player: CharacterBody2D = $"../Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_body_entered(player) -> void:
	print("DOWN")
	camera_control.position.y+=270;
	self.position.x=-200;
	self.position.y=-200;
