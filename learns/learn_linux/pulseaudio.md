## What Is PulseAudio?
PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications. It allows you to do advanced operations on your sound data as it passes between your application and your hardware. Things like transferring the audio to a different machine, changing the sample format or channel count and mixing several sounds into one are easily achieved using a sound server.

https://unix.stackexchange.com/questions/421593/what-are-several-different-and-alternative-methods-to-backup-the-audio-levels-in

First, you have to keep in mind that there are several sets of controls:

1) The actual hardware controls in the Codec (audio chip)
2) The ALSA controls, that cover most (but often not all) hardware controls
3) The Pulseaudio controls, which are mostly software, though a few per-sink/per-source controls access the ALSA controls.

(1) depend on the hardware, but for Intel HDA, you can find them among other things in /proc/asound/card*/codec\#*. Not trivial to restore, though.

(2) is what you probably want. Besides alsactl, you can use amixer to access them (and alsamixer for a UI), e.g. amixer -D hw:0 contents for your first card (cat /proc/asound/pcm for a list). See man amixer on how to set them; you can use a shell script to extract the recording levels you want, and restore them later.

If you are running Pulseaudio, then without -D, you'll see the leves of the pulse pseudo-device that allows ALSA applications to access Pulseaudio. Also note that Pulseaudio my change settings on startup.

(3) can be done with pacmd or pactl; the output is not tool-friendly and requires a bit of parsing. See pacmd help and pactl help for details.

aumix is a legacy tool and probably won't work properly with ALSA or Pulseaudio.


------------------------------------------------------
sink 接收器

```
Sink Input #6
	...
		application.icon_name = "chromium-browser"
Sink Input #10
	Driver: module-virtual-sink.c

Sink #0
	State: RUNNING
	Name: alsa_output.pci-0000_00_1f.3.analog-stereo
Sink #2
	State: RUNNING
	Name: alsa_output.pci-0000_00_1f.3.analog-stereo.vsink

> Sink Input:
pactl list sink-inputs |grep -E "Input|application.name"|grep Chromium -B 1 |grep -v Chromium |sed -n 's/Sink Input \#\(.*\)/\1/p'
> SINK 可以直接用名字
```

```
>
pactl list source-outputs |grep -E "Source Output|application.name" |grep SimpleScreenRecorder -B 1 |grep -v SimpleScreenRecorder |sed -n 's/Source Output #\(.*\)/\1/p'
Source Output #72
		...
		application.name = "SimpleScreenRecorder"
Source #3
	State: RUNNING
	Name: alsa_output.pci-0000_00_1f.3.analog-stereo.vsink.monitor
```

| pavucontrol                                   | pactl               | meaning                            | example                                                 |
|-----------------------------------------------|---------------------|------------------------------------|---------------------------------------------------------|
| playback(有all streams)                       | list sinks          | sound streams go in to this sinks  | Mute: pactl set-sink-mute SINK 1/0/toggle               |
| playback(chromium选走哪个卡built in 还是virt) | list sink-inputs    | sink是接收器,接收器的input就是软件 | pactl move-sink-input 6 2(所以也可以 10 0)(10 0 没意义) |
| output device                                 | list sources        | 软件去接下面的outputs              | Mute: pactl set-source-mute SOURCE 1/0/toggle           |
| Recording                                     | list source-outputs | 软件用outputs 去接？？？           | pactl move-source-output Source-Output Source           |

* `pactl move-source-output ID SOURCE` Move the specified recording stream (identified by its numerical index) to the specified source (identified by its symbolic name or numerical index).
* `move`, 就近原则


```
App[sink-input]   -- PulseAudioService --> [sink(virt)]
	6											2	
vsink[sink-input] -- PulseAudioService --> [sink(stero)]
	10											0

2 10 铁绑，0直接出硬件了


[sources(virt card)]  -- PulseAudioService --> [source-output]App(recorder)
		0											72
```

## Example:

chromiume -> vir 1 -> vir2(mute)

```sh
pactl load-module module-virtual-sink sink_name=VTS1_mute
#31
pactl load-module module-virtual-sink sink_name=VTS2
#32
sink_input=$(pactl list sink-inputs |grep -E "Input|application.name"|grep Chromium -B 1 |grep -v Chromium |sed -n 's/Sink Input \#\(.*\)/\1/p')
pactl move-sink-input $sink_input VTS2

sink_input_VTS2=$(pactl list sink-inputs |grep -E "Input|VTS2"|grep VTS2 -B 1|grep -v VTS2|sed -n 's/Sink Input \#\(.*\)/\1/p')
pactl move-sink-input $sink_input_VTS2 VTS1_mute
pactl set-sink-mute VTS2 0
pactl set-sink-mute VTS1_mute 1

sources_output=$(pactl list source-outputs |grep -E "Source Output|application.name" |grep SimpleScreenRecorder -B 1 |grep -v SimpleScreenRecorder |sed -n 's/Source Output #\(.*\)/\1/p')
pactl move-source-output $sources_output VTS2.monitor
```


