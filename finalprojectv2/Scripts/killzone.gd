extends Area2D
@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $"../../Player"


func _on_body_entered(body: Node2D) -> void:
	#print("DEATH!")
	player.position.x=player.checkpointX;
	player.position.y=player.checkpointY;
	#IDK HOW TO DO CHECKPOINTS!
	
	
	
	
