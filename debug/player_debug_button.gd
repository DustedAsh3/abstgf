extends Button



func _on_pressed() -> void:
	SaveManager.save_game()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_P):
		_on_pressed()
	if Input.is_key_pressed(KEY_L):
		SaveManager.load_game()
