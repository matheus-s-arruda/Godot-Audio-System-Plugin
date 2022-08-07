tool
class_name AudioShot, "res://addons/audio_system/img/ephemeral.svg"
extends AudioStreamPlayer



func _init(audio : AudioStream, volume = null):
	stream = audio
	volume_db = volume
	connect("finished", self, "queue_free")
	autoplay = true




