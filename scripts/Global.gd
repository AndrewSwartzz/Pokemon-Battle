extends Node



@onready var venasaur = %Venasaur
@onready var charizard = %Charizard
@onready var blastoise = %Blastoise

@onready var venasaur_select = $"../Pokemon/Venasaur/VenasaurSelect"
@onready var charizard_select = $"../Pokemon/Charizard/CharizardSelect"
@onready var blastoise_select = $"../Pokemon/Blastoise/BlastoiseSelect"

var p_pokemon = 0

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
	
	
	
	
	
	
	if venasaur.button_pressed:
		venasaur.disabled = true
		p_pokemon = 1
		get_tree().change_scene_to_file("res://scenes/battlescreen.tscn")
	elif charizard.button_pressed:
		charizard.disabled = true
		p_pokemon = 2
		get_tree().change_scene_to_file("res://scenes/battlescreen.tscn")
	elif blastoise.button_pressed:
		blastoise.disabled = true
		p_pokemon = 3
		get_tree().change_scene_to_file("res://scenes/battlescreen.tscn")
	pass
	
	

