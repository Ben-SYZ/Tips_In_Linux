

# https://stackoverflow.com/questions/24185005/how-can-i-get-the-color-of-a-screen-pixel-through-adb

# 2.Check the file size. My screen resolution is 1920*1200, and the file size is 9216012 byte. Noticing that 9216012=1920*1200*4+12, I guess the data file use 4 byte to store every pixel information, and use another 12 byte to do some mystery staff. Just do some more screencaps and I find the 12 byte at the head of each file are the same. So, the additional 12 byte is at the head of the data file.
# 3.Now, things are simple by using dd and hd. Assuming that I want to get the color at (x,y):
# let offset=1200*$y+$x+3
# dd if='screen.dump' bs=4 count=1 skip=$offset 2>/dev/null | hd


# 8294416=16 + (1080*1920)*4
rm fb_me.dump 2> /dev/null
for y in $(seq 1 1920);do
  offset=$((1080*$y+4))
  dd if='./phone_screenshort.dump' bs=4 count=1080 skip=$offset >> fb_me.dump # one row to fb_me.dump
  # echo pixel contains 4 bs
  # count 1080, which is the number of pixels in one row
  # skip the the previous information, ((1080*$y previous pixels) + 4)
  dd if='/dev/zero' bs=4 count=296  >> fb_me.dump	# left from zero
  # 296 = 1370-1080
  echo $i
done
