# AudioSystem Plugin
Audio system plugin for Godot Game Engine

Extract the file in the `res://addons/` folder or create if it doesn't exist.

Activate the plugin in the window `ProjectSettings/Plugins`

<hr/>

### Use:
To play sound without restriction:
```
AudioSystem.play("res://audio.wav")
```

or
```
const PATH = preload("res://audio.wav")

AudioSystem.play(PATH)
```

To play sound if not playing, add TRUE in function:
```
AudioSystem.play("res://audio.wav", true)
AudioSystem.play(PATH, true)
```

You can pass a custom volume as the third argument:
```
AudioSystem.play(PATH, false, 0.9) # from 0.0 to 1.0 
```

#### Music
When called, the new song will interpolate with the previous song:
```
AudioSystem.play_soundtrack(PATH)
```

#### Volume:
You can change these values during the game, all values must be between 0 and 1


volume_master: change the volume of the bus "master"

volume_effects: changes the volume of sounds emitted by func `play()`

volume_music: change the music volume, emitted by func `play_soundtrack()`
 
volume_world: changes the volume of `Audio2D` and `Audio3D` nodes

#### mute:
mute the respective sound group

