[ref](https://www.x.org/releases/X11R7.0/doc/html/DESIGN2.html)

The ServerLayout sections are at the highest level. They bind together the input and output devices that will be used in a session. The input devices are described in the InputDevice sections. Output devices usually consist of multiple independent components (e.g., a graphics board and a monitor). These multiple components are bound together in the Screen sections, and it is these that are referenced by the ServerLayout section. Each Screen section binds together a graphics board and a monitor. The graphics boards are described in the Device sections, and the monitors are described in the Monitor sections.

* ServerLayout: bind
	+ input device( *InputDevice section* )
	+ output device( multiple components(graphics board monitor) )
		- *screen section* : bind
			* graphics board( *Device section* )
			* monitor( *Monitor section* )

```config
# the following are 2 graphics board
Section "Device"
  Identifier "iGPU"
  Driver "modesetting"
  BusID "PCI:0:2:0"
EndSection

Section "Device"
  Identifier "dGPU"
  Driver "nvidia"
EndSection

# Screen section bind the device section, (no graphic board)
# "dGPU" only used when needed
Section "Screen"
  Identifier "iGPU"
  Device "iGPU"
EndSection

# Screen 0 use "iGPU"
Section "ServerLayout"
  Identifier "layout"
  Screen 0 "iGPU"
  Option "AllowNVIDIAGPUScreens"
EndSection
```

----
后面没啥用

## ServerLayout
The ServerLayout section is a new section that is used to identify *which Screen sections are to be used in a multi-headed configuration*, and the relative layout of those screens. It also identifies which InputDevice sections are to be used. Each ServerLayout section has an identifier, a list of Screen section identifiers, and a list of InputDevice section identifiers. ServerFlags options may also be included in a ServerLayout section, making it possible to override the global values in the ServerFlags section.

A ServerLayout section can be made active by being referenced on the command line. In the absence of this, a default will be chosen (the first one found).
```conf
Section "ServerLayout"
	Identifier "Main Layout"
	Screen     0 "Screen 1" ""  ""  ""  "Screen 2"
	Screen     1 "Screen 2"
	Screen     "Screen 3"
EndSection
```
In the absolute case, the upper left corner's coordinates are given after the Absolute keyword. If the coordinates are omitted, a value of (0,0) is assumed. An example of absolute positioning follows:
```
Section "ServerLayout"
	Identifier "Main Layout"
	Screen     0 "Screen 1" Absolute 0 0
	Screen     1 "Screen 2" Absolute 1024 0
	Screen     "Screen 3" Absolute 2048 0
EndSection
```


