tool
extends Node

var current_audio_playing := {}
var master_id = AudioServer.get_bus_index("Master")

var st_player := 0
var soundTrackPlayer := [AudioStreamPlayer.new(), AudioStreamPlayer.new()]
var tween = Tween.new()

var volume_effects := 1.0
var volume_master := 1.0 setget _update_master_volume
var volume_music := 1.0 setget _update_music_volume
var volume_world := 1.0 setget _update_world_volume

var mute_effects := false
var mute_master := false setget _mute_master
var mute_music := false setget _mute_music
var mute_world := false setget _mute_world


func _ready():
	add_child(soundTrackPlayer[0])
	add_child(soundTrackPlayer[1])
	add_child(tween)


func play(_audio_stream, stack := false, volume_custom = null):
	if mute_effects: return
	var volume : float = volume_custom if volume_custom is float else volume_effects
	
	var audio_stream : AudioStream
	if _audio_stream is AudioStream: audio_stream = _audio_stream
	elif _audio_stream is String: audio_stream = load(_audio_stream)
	else: return
	
	if stack:
		if not current_audio_playing.has(audio_stream):
			var audio = AudioShot.new(audio_stream, linear2db(volume))
			current_audio_playing[audio_stream] = audio
			audio.connect("finished", self, "_remove_audio_to_list", [audio_stream], CONNECT_ONESHOT)
			add_child(audio)
	else:
		add_child(AudioShot.new(audio_stream, linear2db(volume)))


func play_soundtrack(_audio_stream):
	var audio_stream : AudioStream
	if _audio_stream is AudioStream: audio_stream = _audio_stream
	elif _audio_stream is String: audio_stream = load(_audio_stream)
	else: return
	
	if soundTrackPlayer[st_player].stream == audio_stream: return
	
	if soundTrackPlayer[st_player].playing:
		fade_volume_player(soundTrackPlayer[st_player], volume_music, 0.01)
	
	st_player = (st_player + 1) % 2
	soundTrackPlayer[st_player].stream = audio_stream
	soundTrackPlayer[st_player].playing = true
	fade_volume_player(soundTrackPlayer[st_player], 0.01, volume_music)


func fade_volume_player(player : AudioStreamPlayer, v_init : float, v_target : float, time := 2.0):
	tween.interpolate_property(player, "volume_db", linear2db(v_init), linear2db(v_target), time)
	tween.start()


func _remove_audio_to_list(audio_stream : AudioStream):
	current_audio_playing.erase(audio_stream)


func _update_master_volume(value : float):
	volume_master = clamp(value, 0.0, 1.0)
	if not mute_master:
		AudioServer.set_bus_volume_db(master_id, linear2db(volume_master))


func _update_music_volume(value : float):
	volume_music = clamp(value, 0.0, 3.0)
	if not mute_master:
		soundTrackPlayer[st_player].volume_db = linear2db(volume_music)


func _update_world_volume(value : float):
	volume_world = clamp(value, 0.0, 3.0)
	if not mute_master:
		get_tree().call_group("WorldAudio", "update_volume", volume_world)


func _mute_master(value : bool):
	mute_master = value
	if mute_master:
		AudioServer.set_bus_volume_db(master_id, linear2db(volume_master * int(!mute_master)))


func _mute_music(value : bool):
	mute_music = value
	soundTrackPlayer[st_player].volume_db = linear2db(volume_music * int(!mute_music))


func _mute_world(value : bool):
	mute_world = value
	get_tree().call_group("WorldAudio", "update_volume", volume_world * int(!mute_world))


