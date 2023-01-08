extends Node2D

@onready var hole = Vector2i.ZERO
@onready var can_be_hit = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.scale = Vector2(0,0)
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D,"scale",Vector2(1,1),1).set_trans(Tween.TRANS_BOUNCE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("crush")):
		if can_be_hit == true:
			print(hole)
			Global.score = Global.score+1
			Global.play_plop()
			var tween = get_tree().create_tween()
			tween.tween_property($Sprite2D,"modulate",Color.RED,1).set_trans(Tween.TRANS_SINE)
#			tween.tween_property($Sprite2D,"scale",Vector2(0,0),1).set_trans(Tween.TRANS_BOUNCE)
			await tween.finished
			destroy()
			


func _on_area_2d_mouse_entered() -> void:
	can_be_hit = true
		
		

func _on_area_2d_mouse_exited() -> void:
	can_be_hit = false


func pop(pos: Vector2) -> void:
	position = pos
	position.y = position.y-15
	

func destroy() -> void:
	for i in Global.tab_of_holes_taken:
		if i == hole:
			Global.tab_of_holes_taken.erase(hole)
	queue_free()
