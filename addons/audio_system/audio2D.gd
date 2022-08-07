tool
extends AudioStreamPlayer2D


var volume_base = db2linear(volume_db)


func _init():
	add_to_group("WorldAudio")


func _ready():
	var audiosystem : Node = get_tree().get_nodes_in_group("AudioSystem")[0]
	if audiosystem:
		update_volume(audiosystem.volume_world)


func update_volume(volume : float):
	volume_db = linear2db(volume * volume_base)
