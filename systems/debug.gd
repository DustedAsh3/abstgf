extends Node

var log_output : String

func Log(text : String):
	print(text)
	log_output += text + "\n"
