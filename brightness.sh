brightnessctl -d 'intel_backlight' set +6% >/dev/null
xbacklight -d $DISPLAY -dec 6
# https://linuxhint.com/display_brightness_commandline/
