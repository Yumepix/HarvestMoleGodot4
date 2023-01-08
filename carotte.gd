extends Node2D

@onready var can_be_hit = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("crush")):
		if can_be_hit == true:
			if Global.score > 1:
				Global.score = Global.score-1
	

func pop(pos: Vector2) -> void:
	position = pos

func _on_area_2d_mouse_entered() -> void:
	can_be_hit = true
		
		

func _on_area_2d_mouse_exited() -> void:
	can_be_hit = false
