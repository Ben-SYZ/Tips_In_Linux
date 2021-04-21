```config
#~/.config/i3/config
exec --no-startup-id xautolock -corners -0+0 -cornersize 30 -cornerdelay 2 -time 5 -locker "source /home/ben/.config/i3/scripts/player_screen.sh && xset s 7 -b; i3lock-fancy -n; xset s off" -detectsleep -bell 0
```

GitRepos
https://github.com/Lixxia/i3lock

```
unlock_indicator.c 
extern int input_position;
```

