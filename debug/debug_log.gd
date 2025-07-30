extends TextEdit

func _ready() -> void:
	hide()
	process_mode = PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event.is_action_released("open_console"):
		show()
	if event.is_action_released("menu"):
		hide()
	if event.is_action_released("execute_command"):
		hide()

func _process(delta: float) -> void:
	text = Debug.log_output
	scroll_vertical = get_line_count()
