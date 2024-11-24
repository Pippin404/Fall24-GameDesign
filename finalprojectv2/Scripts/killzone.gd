extends Area2D
@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $"../../Player"
@onready var dthsnd: AudioStreamPlayer2D = $dthsnd


func _on_body_entered(body: Node2D) -> void:
	#print("DEATH!")
	player.position.x=player.checkpointX;
	player.position.y=player.checkpointY;
	dthsnd.play();
	#IDK HOW TO DO CHECKPOINTS!
	
	
	
	
