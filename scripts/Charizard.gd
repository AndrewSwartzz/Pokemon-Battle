extends Button

@onready var charizard = $"."
@onready var charizard_select = $CharizardSelect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if charizard.is_hovered():
		charizard_select.visible = true
	else:
		charizard_select.visible = false
		
