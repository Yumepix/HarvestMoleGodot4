extends Node2D

var tab_of_holes_taken = []
var tab_of_carottes_taken = []
@onready var score: int = 0


func play_crush()-> void:
	$snd_Crush.play()

func play_ouch()-> void:
	$snd_Ouch.play()
	
func play_gameover()-> void:
	$snd_Gameover.play()

	
func play_plop()-> void:
	$snd_Plop.play()
