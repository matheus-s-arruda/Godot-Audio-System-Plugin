tool
extends EditorPlugin

const ICONE3D = preload("res://addons/audio_system/img/audio3D.svg")
const ICONE2D = preload("res://addons/audio_system/img/audio2D.svg")
const TYPE3D = preload("res://addons/audio_system/audio3D.gd")
const TYPE2D = preload("res://addons/audio_system/audio2D.gd")


func _enter_tree():
	add_autoload_singleton("AudioSystem", "res://addons/audio_system/autoload.gd")
	add_custom_type("Audio3D", "AudioStreamPlayer3D", TYPE3D, ICONE3D)
	add_custom_type("Audio2D", "AudioStreamPlayer2D", TYPE2D, ICONE2D)


func _exit_tree():
	remove_autoload_singleton("AudioSystem")
	remove_custom_type("Audio3D")
	remove_custom_type("Audio2D")

