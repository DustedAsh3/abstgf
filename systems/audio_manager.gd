extends Node

var current_music

enum ReverbPreset {
	CAVE,
	NORMAL,
	HALL,
	CHAMBER,
	TUNNEL
}

signal emit_audio_event(event)
signal on_event_bus_signal(event)

func play_sfx(sound_name):
	pass

func play_music(track_name):
	pass

func stop_music():
	pass

func set_volume(level):
	pass
