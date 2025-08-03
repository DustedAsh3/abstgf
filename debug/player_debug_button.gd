extends Control

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_P):
		SaveManager.save_game()
	if Input.is_key_pressed(KEY_L):
		SaveManager.load_game()
