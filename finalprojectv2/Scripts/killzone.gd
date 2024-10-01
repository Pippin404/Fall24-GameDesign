extends Area2D
@onready var timer: Timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	print("DEATH!")
	get_tree().reload_current_scene();
	
	## Timer DOES NOT WORK this will do I guess
	
	
	
