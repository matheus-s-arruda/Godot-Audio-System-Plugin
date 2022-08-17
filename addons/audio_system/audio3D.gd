tool
extends AudioStreamPlayer3D


var volume_base : float = db2linear(unit_db)


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
	unit_db = linear2db(volume_base * volume)
