extends Node2D

@onready var _hammer_animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("crush")):
		_hammer_animation.play("crush_anim")
		Global.play_crush()
		

func init() -> void:
	position = Vector2(0,0)
