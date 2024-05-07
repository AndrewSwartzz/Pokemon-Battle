extends Control

@onready var p_pokemon_sprite = $PPokemon_Sprite
@onready var c_pokemon_sprite = $CPokemon_Sprite

@onready var p_poke_name = $PPokemon_Sprite/PPoke_Name
@onready var c_poke_name = $CPokemon_Sprite/CPoke_Name

@onready var p_poke_status = $PPokemon_Sprite/PPoke_Status
@onready var c_poke_status = $CPokemon_Sprite/CPoke_Status

@onready var p_poke_health = $PPokemon_Sprite/PPoke_Health

@onready var textbox = $Textbox
@onready var textbox_label = $Textbox/TextboxLabel
@onready var actions = $CanvasLayer/Actions

var protecting = false
var enemy_protecting = false

signal textbox_closed
	
# Called when the node enters the scene tree for the first time.
func _ready():
	textbox.hide()
	actions.hide()
	if globalselect.p_pokemon == "Charizard":
		var p_pokemon = "Charizard"
		globalselect.poke_dict[p_pokemon] = [500, 50, 'None']
		p_pokemon_sprite.play("charizard")
		p_poke_name.text = "Charizard" 
		p_poke_status.text = "[Status:" +  str(globalselect.poke_dict[p_pokemon][2]) + "]"
		p_poke_health.value = globalselect.poke_dict[p_pokemon][0]
		var c_pokemons = ["Blastoise", "Venasaur"]
		globalselect.c_pokemon = c_pokemons[randi() % c_pokemons.size()]
		if globalselect.c_pokemon == "Venasaur":
			c_pokemon_sprite.play("vensaur")
		else:
			c_pokemon_sprite.play("blastoise")
		c_poke_name.text = globalselect.c_pokemon
		globalselect.poke_dict[globalselect.c_pokemon] = [500, 50, 'None']
		c_poke_status.text = "[Status:" +  str(globalselect.poke_dict[globalselect.c_pokemon][2]) + "]"
		set_health($PPokemon_Sprite/PPoke_Health, globalselect.poke_dict[p_pokemon][0], p_pokemon, "Health_Label")
		set_health($CPokemon_Sprite/CPoke_Health, globalselect.poke_dict[globalselect.c_pokemon][0], globalselect.c_pokemon, "CHealth_Label" )
		display_text("Oppenent Sends Out " + str(globalselect.c_pokemon) + "!")
		await self.textbox_closed
		actions.show()
	if globalselect.p_pokemon == "Blastoise":
		var p_pokemon = "Blastoise"
		globalselect.poke_dict[p_pokemon] = [500, 50, 'None']
		p_pokemon_sprite.play("blastoise")
		p_poke_name.text = "Blastoise"
		p_poke_status.text = "[Status:" +  str(globalselect.poke_dict[p_pokemon][2]) + "]"
		var c_pokemons = ["Charizard", "Venasaur"]
		globalselect.c_pokemon = c_pokemons[randi() % c_pokemons.size()]
		if globalselect.c_pokemon == "Venasaur":
			c_pokemon_sprite.play("vensaur")
		else:
			c_pokemon_sprite.play("charizard")
		c_poke_name.text = globalselect.c_pokemon
		globalselect.poke_dict[globalselect.c_pokemon] = [500, 50, 'None']
		c_poke_status.text = "[Status:" +  str(globalselect.poke_dict[globalselect.c_pokemon][2]) + "]"
		set_health($PPokemon_Sprite/PPoke_Health, globalselect.poke_dict[p_pokemon][0], p_pokemon, "Health_Label")
		set_health($CPokemon_Sprite/CPoke_Health, globalselect.poke_dict[globalselect.c_pokemon][0], globalselect.c_pokemon, "CHealth_Label" )
		display_text("Oppenent Sends Out " + str(globalselect.c_pokemon) + "!")
		await self.textbox_closed
		actions.show()
	if globalselect.p_pokemon == "Venasaur":
		var p_pokemon = "Venasaur"
		globalselect.poke_dict[p_pokemon] = [500, 50, 'None']
		p_pokemon_sprite.play("venasaur")
		p_poke_name.text = "Venasaur"
		p_poke_status.text = "[Status:" +  str(globalselect.poke_dict[p_pokemon][2]) + "]"
		var c_pokemons = ["Blastoise", "Charizard"]
		globalselect.c_pokemon = c_pokemons[randi() % c_pokemons.size()]
		if globalselect.c_pokemon == "Charizard":
			c_pokemon_sprite.play("charizard")
		else:
			c_pokemon_sprite.play("blastoise")
		c_poke_name.text = globalselect.c_pokemon
		globalselect.poke_dict[globalselect.c_pokemon] = [500, 50, 'None']
		c_poke_status.text = "[Status:" +  str(globalselect.poke_dict[globalselect.c_pokemon][2]) + "]"
		set_health($PPokemon_Sprite/PPoke_Health, globalselect.poke_dict[p_pokemon][0], p_pokemon, "Health_Label")
		set_health($CPokemon_Sprite/CPoke_Health, globalselect.poke_dict[globalselect.c_pokemon][0], globalselect.c_pokemon, "CHealth_Label" )
		display_text("Oppenent Sends Out " + str(globalselect.c_pokemon) + "!")
		await self.textbox_closed
		actions.show()
	pass
	
func display_text(text):
	textbox.show()
	textbox_label.text = text

func _enemy_turn():
	var num = randi_range(1,10)
	if num in [1,2,3,4]:
		return "Attack"
	if num in [5,6]:
		return "Protect"
	if num in [7,8]:
		return "Poison"
	if num in [9,10]:
		return "Howl"
	

func _enemy_attack():
	actions.hide()
	textbox.show()
	display_text(globalselect.c_pokemon + " Attacks!")
	await self.textbox_closed
	
	if protecting == true:
		protecting = false
		display_text(globalselect.p_pokemon + " was Protected!")
		await self.textbox_closed
	else:
		globalselect.poke_dict[globalselect.p_pokemon][0] = max(0, globalselect.poke_dict[globalselect.p_pokemon][0] - globalselect.poke_dict[globalselect.c_pokemon][1])
		set_health($PPokemon_Sprite/PPoke_Health, globalselect.poke_dict[globalselect.p_pokemon][0], globalselect.p_pokemon, "Health_Label" )
		
		$AnimationPlayer.play("player damage")
		await $AnimationPlayer.animation_finished
		
		display_text("Oppenent dealt " + str(globalselect.poke_dict[globalselect.c_pokemon][1]) + " damage")
		await self.textbox_closed
		actions.show()
		
func _enemy_protect():
	actions.hide()
	enemy_protecting = true
	
	display_text(globalselect.c_pokemon + " Protects!")
	await self.textbox_closed
	actions.show()
	
func _enemy_poison():
	globalselect.p_poison = 4
	actions.hide()
	display_text("You are Poisoned for 4 Turns!")
	await self.textbox_closed
	actions.show()
	
func _enemy_howl():
	globalselect.c_howl = 4
	actions.hide()
	display_text("Oppenent Used Howl" )
	await self.textbox_closed
	actions.show()
	
func set_health(Poke_Health, health, pokemon, health_label):
	Poke_Health.value = health
	Poke_Health.get_node(health_label).text = "HP: " + str(globalselect.poke_dict[pokemon][0]) + "/500"

func _faint_check():
	if globalselect.poke_dict[globalselect.c_pokemon][0] <= 0:
		actions.hide()
		display_text(globalselect.c_pokemon + " Has Fainted!")
		await self.textbox_closed
		$AnimationPlayer.play("enemy faint")
		await $AnimationPlayer.animation_finished
		await get_tree().create_timer(5).timeout
		get_tree().quit()
	
	if globalselect.poke_dict[globalselect.p_pokemon][0] <= 0:
		actions.hide()
		display_text(globalselect.p_pokemon + " Has Fainted!")
		await self.textbox_closed
		$AnimationPlayer.play("player faint")
		await $AnimationPlayer.animation_finished
		await get_tree().create_timer(5).timeout
		get_tree().quit()	
	
	await self.textbox_closed	
	actions.show()
func _input(event):
	if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and textbox.visible:
		textbox.hide()
		emit_signal("textbox_closed")


func _on_attack_pressed():
	globalselect.choice = _enemy_turn()
	actions.hide()
	display_text(globalselect.p_pokemon + " Attacks!")
	await self.textbox_closed
	if globalselect.choice == "Protect":
		display_text(globalselect.c_pokemon + " was Protected!")
		await self.textbox_closed
		actions.show()
	else:
		globalselect.poke_dict[globalselect.c_pokemon][0] = max(0, globalselect.poke_dict[globalselect.c_pokemon][0] - globalselect.poke_dict[globalselect.p_pokemon][1])
		set_health($CPokemon_Sprite/CPoke_Health, globalselect.poke_dict[globalselect.c_pokemon][0], globalselect.c_pokemon, "CHealth_Label" )
		$AnimationPlayer.play("enemy damge")
		await $AnimationPlayer.animation_finished
		display_text("You dealt " + str(globalselect.poke_dict[globalselect.p_pokemon][1]) + " damage")
		await self.textbox_closed
	
	_faint_check()
		
	if globalselect.choice == "Attack":
		actions.hide()
		textbox.show()
		display_text(globalselect.c_pokemon + " Attacks!")
		await self.textbox_closed
	
		if protecting == true:
			protecting = false
			display_text(globalselect.p_pokemon + " was Protected!")
			await self.textbox_closed
		else:
			globalselect.poke_dict[globalselect.p_pokemon][0] = max(0, globalselect.poke_dict[globalselect.p_pokemon][0] - globalselect.poke_dict[globalselect.c_pokemon][1])
			set_health($PPokemon_Sprite/PPoke_Health, globalselect.poke_dict[globalselect.p_pokemon][0], globalselect.p_pokemon, "Health_Label" )
		
			$AnimationPlayer.play("player damage")
			await $AnimationPlayer.animation_finished
		
			display_text("Oppenent dealt " + str(globalselect.poke_dict[globalselect.c_pokemon][1]) + " damage")
			await self.textbox_closed
		
	if globalselect.choice == "Poison":
		globalselect.p_poison = 4
		actions.hide()
		display_text("You are Poisoned for 4 Turns!")
		await self.textbox_closed
		
	if globalselect.choice == "Howl":
		globalselect.c_howl = 4
		actions.hide()
		display_text("Oppenent Used Howl" )
		await self.textbox_closed
		actions.show()
	
	_howl_check(globalselect.p_pokemon, globalselect.c_pokemon)
	_poison_check(globalselect.p_pokemon, globalselect.c_pokemon)

	_faint_check()
	
func _on_protect_pressed():
	actions.hide()
	protecting = true
	globalselect.choice = _enemy_turn()
	
	display_text(globalselect.p_pokemon + " Protects!")
	await self.textbox_closed
	
	if globalselect.choice == "Attack":
		actions.hide()
		textbox.show()
		display_text(globalselect.c_pokemon + " Attacks!")
		await self.textbox_closed
	
		if protecting == true:
			protecting = false
			display_text(globalselect.p_pokemon + " was Protected!")
			await self.textbox_closed
			actions.show()
		else:
			globalselect.poke_dict[globalselect.p_pokemon][0] = max(0, globalselect.poke_dict[globalselect.p_pokemon][0] - globalselect.poke_dict[globalselect.c_pokemon][1])
			set_health($PPokemon_Sprite/PPoke_Health, globalselect.poke_dict[globalselect.p_pokemon][0], globalselect.p_pokemon, "Health_Label" )
		
			$AnimationPlayer.play("player damage")
			await $AnimationPlayer.animation_finished
		
			display_text("Oppenent dealt " + str(globalselect.poke_dict[globalselect.c_pokemon][1]) + " damage")
			await self.textbox_closed
			actions.show()
		
	if globalselect.choice == "Protect":
		actions.hide()
		display_text("Both Pokemon Protected!")
		await self.textbox_closed
		actions.show()
		
	if globalselect.choice == "Poison":
		globalselect.p_poison = 4
		actions.hide()
		display_text("You are Poisoned for 4 Turns!")
		await self.textbox_closed

	_howl_check(globalselect.p_pokemon, globalselect.c_pokemon)
	_poison_check(globalselect.p_pokemon, globalselect.c_pokemon)

	_faint_check()
func _on_poison_pressed():
	actions.hide()
	globalselect.choice = _enemy_turn()
	
	globalselect.c_poison = 4
	actions.hide()
	display_text("Oppenent is Poisoned for 4 Turns!")
	await self.textbox_closed
	
	if globalselect.choice == "Attack":
		actions.hide()
		textbox.show()
		display_text(globalselect.c_pokemon + " Attacks!")
		await self.textbox_closed
	
		if protecting == true:
			protecting = false
			display_text(globalselect.p_pokemon + " was Protected!")
			await self.textbox_closed
		else:
			globalselect.poke_dict[globalselect.p_pokemon][0] = max(0, globalselect.poke_dict[globalselect.p_pokemon][0] - globalselect.poke_dict[globalselect.c_pokemon][1])
			set_health($PPokemon_Sprite/PPoke_Health, globalselect.poke_dict[globalselect.p_pokemon][0], globalselect.p_pokemon, "Health_Label" )
		
			$AnimationPlayer.play("player damage")
			await $AnimationPlayer.animation_finished
		
			display_text("Oppenent dealt " + str(globalselect.poke_dict[globalselect.c_pokemon][1]) + " damage")
			await self.textbox_closed
			actions.show()
		
	if globalselect.choice == "Poison":
		globalselect.p_poison = 4
		actions.hide()
		display_text("You are Poisoned for 4 Turns!")
		await self.textbox_closed
		actions.show()
		
	if globalselect.choice == "Howl":
		globalselect.c_howl = 4
		actions.hide()
		display_text("Oppenent Used Howl" )
		await self.textbox_closed
		actions.show()
	if globalselect.choice == "Protect":
		display_text(globalselect.c_pokemon + " Protects!")
		await self.textbox_closed
		
	_poison_check(globalselect.p_pokemon, globalselect.c_pokemon)
	_howl_check(globalselect.p_pokemon, globalselect.c_pokemon)
	
	_faint_check()
func _on_howl_pressed():
	actions.hide()
	globalselect.choice = _enemy_turn()
	
	globalselect.p_howl = 4
	actions.hide()
	display_text(globalselect.p_pokemon + " used Howl" )
	await self.textbox_closed
	
	if globalselect.choice == "Attack":
		actions.hide()
		textbox.show()
		display_text(globalselect.c_pokemon + " Attacks!")
		await self.textbox_closed
	
		if protecting == true:
			protecting = false
			display_text(globalselect.p_pokemon + " was Protected!")
			await self.textbox_closed
		else:
			globalselect.poke_dict[globalselect.p_pokemon][0] = max(0, globalselect.poke_dict[globalselect.p_pokemon][0] - globalselect.poke_dict[globalselect.c_pokemon][1])
			set_health($PPokemon_Sprite/PPoke_Health, globalselect.poke_dict[globalselect.p_pokemon][0], globalselect.p_pokemon, "Health_Label" )
		
			$AnimationPlayer.play("player damage")
			await $AnimationPlayer.animation_finished
		
			display_text("Oppenent dealt " + str(globalselect.poke_dict[globalselect.c_pokemon][1]) + " damage")
			await self.textbox_closed
			actions.show()
		
	if globalselect.choice == "Poison":
		globalselect.p_poison = 4
		actions.hide()
		display_text("You are Poisoned for 4 Turns!")
		await self.textbox_closed
		actions.show()
		
	if globalselect.choice == "Howl":
		globalselect.c_howl = 4
		actions.hide()
		display_text("Oppenent Used Howl" )
		await self.textbox_closed
		actions.show()
	
	if globalselect.choice == "Protect":
		display_text(globalselect.c_pokemon + " Protects!")
		await self.textbox_closed
	
	_poison_check(globalselect.p_pokemon, globalselect.c_pokemon)
	_howl_check(globalselect.p_pokemon, globalselect.c_pokemon)
	
	_faint_check()
func _poison_check(p_pokemon, c_pokemon):
	actions.hide()
	if globalselect.p_poison > 0:
		p_poke_status.text = "Poisoned"
		display_text(p_pokemon + " is damaged by poison")
		await self.textbox_closed
		globalselect.poke_dict[p_pokemon][0] -= 25
		set_health($PPokemon_Sprite/PPoke_Health, globalselect.poke_dict[p_pokemon][0], p_pokemon, "Health_Label" )
		$AnimationPlayer.play("player damage")
		globalselect.p_poison = globalselect.p_poison - 1
	
	if globalselect.p_poison == 0:
		p_poke_status.text = "[Status:None]"
	
	if globalselect.c_poison > 0:
		c_poke_status.text = "Poisoned"
		display_text(c_pokemon + " is damaged by poison")
		await self.textbox_closed
		globalselect.poke_dict[c_pokemon][0] -= 25
		set_health($CPokemon_Sprite/CPoke_Health, globalselect.poke_dict[c_pokemon][0], c_pokemon, "CHealth_Label" )
		$AnimationPlayer.play("enemy damge")
		await self.textbox_closed
		globalselect.c_poison = globalselect.c_poison - 1
	
	if globalselect.c_poison == 0:
		c_poke_status.text = "[Status:None]"
	
func _howl_check(p_pokemon, c_pokemon):
	if globalselect.p_howl > 0: 
		globalselect.poke_dict[p_pokemon][1] = 75
		display_text("Your Attack is 75 for " + str(globalselect.p_howl) + " more turns")
		await self.textbox_closed
		globalselect.p_howl = globalselect.p_howl - 1

	if globalselect.c_howl > 0: 
		globalselect.poke_dict[c_pokemon][1] = 75
		display_text("Oppenet's Attack is 75 for " + str(globalselect.c_howl) + " more turns")
		await self.textbox_closed
		globalselect.c_howl = globalselect.c_howl - 1	
	
