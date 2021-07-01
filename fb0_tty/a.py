import keyboard  # using module keyboard
import time

def plot():
    xsize = 1376
    ysize = 768
    with open('data.out', 'wb') as f:
        for y in range(0,ysize):
            for x in range(0,xsize):
                r = int(min(x / (xsize/256),255))
                g = int(min(y / (ysize/256),255))
                #b = 0
                b = int(min(y / (ysize/256),255))
                #r,b,g = 0,0,0
                #if x<683:
                #    r=255
                #r=255

                f.write((b).to_bytes(1, byteorder='little'))
                f.write((g).to_bytes(1, byteorder='little'))
                f.write((r).to_bytes(1, byteorder='little'))
                f.write((0).to_bytes(1, byteorder='little'))
            #print('Debug: x = %s' % str(x))
            #break
    pass

def move():
    pass

def bullet():
    pass


def main():
    while True:  # making a loop
        try:  # used try so that if user pressed other than the given key error will not be shown
            if keyboard.is_pressed('h'):  # if key 'q' is pressed 
                # left
                pass
                time.sleep(0.2)
            elif keyboard.is_pressed('i'):  # if key 'q' is pressed 
                # right
                pass
                time.sleep(0.2)
            elif keyboard.is_pressed(' '):  # if key 'q' is pressed 
                # bullet
                print('You Pressed A Key!')
                #break  # finishing the loop
                time.sleep(0.2)
        except:
            break
    #        break  # if user pressed a key other than the given key the loop will break



#
#
#
#
main()
