extends Node


func CreateTimer(parent : Node, wait_time := 1.0, is_one_shot := false, is_autostart := true):
	var timer = Timer.new()
	timer.wait_time = wait_time
	timer.one_shot = is_one_shot
	timer.autostart = is_autostart
	parent.add_child(timer)
	return timer
