https://stackoverflow.com/questions/5562253/switch-case-with-fallthrough/24544780

注意 通过 `;;&` 继续之后是要通过"duplicate", 和 "left" 的 `;;` 断掉的

```sh
muti_window_set(){
  case "$MODE" in
    "off")
      #echo off;;
      xrandr --output $SECONDARY_SCREEN_NAME --off;;
    "duplicate" | "left" )
      xrandr --output $SECONDARY_SCREEN_NAME --auto;
      xrandr --output $MAIN_SCREEN_NAME --auto;;&
    "duplicate")
      echo auto;
      xrandr --output $SECONDARY_SCREEN_NAME --same-as $MAIN_SCREEN_NAME;;
    "left")
      echo left;
      xrandr --output $SECONDARY_SCREEN_NAME --left-of $MAIN_SCREEN_NAME;;
    *)
      echo other
      #xrandr --output $SECONDARY_SCREEN_NAME --off;;
  esac
  #variety_set
}
```


