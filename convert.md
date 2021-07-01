```sh
    pixel_color=$(convert .screenshot.png -crop "1x1+$pos_x+$pos_y" txt:- |awk 'NR==2{print $3}')

```
