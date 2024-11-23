extends Area2D
@onready var camera_control: Node2D = $"../CameraControl"



func _on_body_entered(body: Node2D) -> void:
		camera_control.position.y+=camera_control.CAMERA_HEIGHT;
		print("CAM DOWN");
