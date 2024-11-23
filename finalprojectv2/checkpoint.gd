extends Area2D
@onready var player: CharacterBody2D = $"../../Player"
@onready var elevator_ding: AudioStreamPlayer2D = $elevatorDing
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var touchable=true;

func _on_body_entered(body: Node2D) -> void:
	if touchable:
		player.checkpointX=self.position.x;
		player.checkpointY=self.position.y;
		print("Checkpoint assigned to ");
		print(self.position.x);
		print(self.position.y);
		elevator_ding.play();
		animated_sprite_2d.frame=1;
		touchable=false;
