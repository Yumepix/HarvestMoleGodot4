extends Node2D

@onready var can_be_hit = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(can_be_hit)





func _on_area_2d_mouse_entered() -> void:
	can_be_hit = true
		
		

func _on_area_2d_mouse_exited() -> void:
	can_be_hit = false
