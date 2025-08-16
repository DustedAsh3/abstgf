extends Node

var log_output : String

func Log(text : Variant):
	var txt = str(text)
	print(txt)
	log_output += txt + "\n"
