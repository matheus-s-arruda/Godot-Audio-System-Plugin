tool
extends AudioStreamPlayer2D


var volume_base : float = db2linear(volume_db)
var audiosystem : Node


func _init():
	add_to_group("WorldAudio")


func _ready():
	audiosystem = get_viewport().get_node("AudioSystem")
	
	if audiosystem:
		update_volume(audiosystem.volume_world)
	else:
		print("Node AudioSystem not found")


func update_volume(volume : float):
	volume_db = linear2db(volume * volume_base)
