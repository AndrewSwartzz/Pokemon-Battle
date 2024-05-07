extends Node2D

@onready var venasaur = $TextureRect/Venasaur
@onready var venasaur_select = $TextureRect/Venasaur/VenasaurSelect

@onready var charizard = $TextureRect/Charizard
@onready var charizard_select = $TextureRect/Charizard/CharizardSelect

@onready var blastoise = $TextureRect/Blastoise
@onready var blastoise_select = $TextureRect/Blastoise/BlastoiseSelect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if blastoise.is_hovered():
		blastoise_select.visible = true
	else:
		blastoise_select.visible = false
		
	if charizard.is_hovered():
		charizard_select.visible = true
	else:
		charizard_select.visible = false
		
	if venasaur.is_hovered():
		venasaur_select.visible = true
	else:
		venasaur_select.visible = false
	pass


func _on_venasaur_pressed():
	globalselect.p_pokemon = 'Venasaur'
	get_tree().change_scene_to_file("res://scenes/battlescreen.tscn")
	
	pass # Replace with function body.


func _on_charizard_pressed():
	globalselect.p_pokemon = 'Charizard'
	get_tree().change_scene_to_file("res://scenes/battlescreen.tscn")
	pass # Replace with function body.


func _on_blastoise_pressed():
	globalselect.p_pokemon = 'Blastoise'
	get_tree().change_scene_to_file("res://scenes/battlescreen.tscn")
	pass # Replace with function body.
