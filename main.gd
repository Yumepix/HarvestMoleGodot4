extends Node2D

#const CELL_SIZE = Vector2(64.0,48.0)
#const nb_cols = 8
#const nb_lines = 7
@onready var tab_of_holes = []
@onready var tab_of_carottes = []
@onready var begin_grid = Vector2.ZERO
@onready var background = $Background
@onready var hammer = $Hammer
@onready var score = $Score
@onready var timer = $Timer


var nb_ennemies = 0
var nb_farmers = 0
var Mole = preload("res://taupe.tscn")
var Carotte = preload("res://carotte.tscn")
var Farmers = preload("res://farmer.tscn")

func _ready() -> void:
	# cache le curseur
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	
	
	randomize()
	
	var all_cells = background.get_used_cells(0)
	for cell in all_cells:
		var tile = background.get_cell_atlas_coords(0,cell)
		if tile == Vector2i(5,1):
			tab_of_holes.append(cell)
		if tile == Vector2i(2,2) || tile == Vector2i(5,2) || tile == Vector2i(5,3):
			tab_of_carottes.append(cell)
	
	tab_of_holes.shuffle()
	pop_carotte()


	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	# Atlas = le positionnement des tuiles source sur la tilemap
	print(timer.time_left)
	
	if (timer.time_left == 0):
		get_tree().change_scene_to_file("res://end_screen.tscn")
	

	score.text = str(Global.score)
	
	var pos_mouse = get_global_mouse_position()
	var pos_mousei = Vector2i(pos_mouse)
	
	# position de la tuile
	var tile = background.local_to_map(pos_mouse)
#	position de la tuile sur l'atlas
#	print(background.get_cell_atlas_coords(0,tile))
	
	# modifier une tile
#	background.set_cell(0,tile,2,Vector2i(5,1))

	hammer.position = pos_mouse
	nb_ennemies = get_tree().get_nodes_in_group("ennemies").size();
	nb_farmers = get_tree().get_nodes_in_group("farmers").size();
#	print(nb_ennemies)
#	print(Global.tab_of_holes_taken)
	pop_mole()
	pop_farmer()


func pop_carotte() -> void:
	for c in tab_of_carottes:
		var carotte = Carotte.instantiate()
		carotte.pop(background.map_to_local(c))
		add_child(carotte)

func pop_mole() -> void:
	if (nb_ennemies < 4):	
		var rand_index:int = randi() % tab_of_holes.size()
		var hole = tab_of_holes[rand_index]
		if !is_hole_taken(hole):
			var taupe = Mole.instantiate()
			taupe.pop(background.map_to_local(hole))
			add_child(taupe)
			taupe.hole = hole
			Global.tab_of_holes_taken.append(hole)
		else:
			print("hole taken")

func pop_farmer() -> void:
	if (nb_farmers < 4):	
		var rand_index:int = randi() % tab_of_holes.size()
		var hole = tab_of_holes[rand_index]
		if !is_hole_taken(hole):
			var farmer = Farmers.instantiate()
			farmer.pop(background.map_to_local(hole))
			add_child(farmer)
			farmer.hole = hole
			Global.tab_of_holes_taken.append(hole)
		else:
			print("hole taken")


func is_hole_taken(hole: Vector2i):
	for h in Global.tab_of_holes_taken:
		if h == hole:
			return true
	return false

#func is_cursor_in_grid(pos_mouse):
#	if pos_mouse.x > begin_grid.x \
#	and pos_mouse.x < begin_grid.x+(CELL_SIZE.x * nb_cols) \
#	and pos_mouse.y > begin_grid.y \
#	and pos_mouse.y < begin_grid.y+ (CELL_SIZE.y * nb_lines):
#		print("in grid")
#		return true
#	else:
#		print("out of grid")
#		return false



func _on_timer_2_timeout() -> void:
	$ProgressBar.value-=5
