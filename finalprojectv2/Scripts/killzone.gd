extends Area2D
@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $"../Player"


func _on_body_entered(body: Node2D) -> void:
	#print("DEATH!")
	get_tree().reload_current_scene();
	#IDK HOW TO DO CHECKPOINTS!
	
	
	
	
