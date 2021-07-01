import keyboard  # using module keyboard
import time
import os
def main():
    x,y=600,700
    while True:  # making a loop
        try:  # used try so that if user pressed other than the given key error will not be shown
            if keyboard.is_pressed('h'):  # if key 'q' is pressed 
                # left
                pass
                x=x-20
                plot(x,y)
                time.sleep(0.2)
            elif keyboard.is_pressed('i'):  # if key 'q' is pressed 
                # right
                pass
                x=x+20
                plot(x,y)
                time.sleep(0.2)
            elif keyboard.is_pressed(' '):  # if key 'q' is pressed 
                # bullet
                print('You Pressed A Key!')
                #break  # finishing the loop
                time.sleep(0.2)
        except:
            break
    #        break  # if user pressed a key other than the given key the loop will break

def plane_plot(x,y,x_airplane,y_airplane,width):
    r,g,b=0,0,0
    #print(x,y)
    # / (x_airplane+ width/2,y_airplane), (x_airplane,y_airplane + width)
    # y = -2(x-(x_airplane+ width/2)) + y_airplane

    # \ (x_airplane+ width/2,y_airplane), (x_airplane+width,y_airplane + width)
    # y = 2*(x-(x_airplane+ width/2)) + y_airplane


    # xxx
    # / y = 2*(x-(x_airplane+width/2)) + y_airplane
    # \ y = -2*(x-(x_airplane+width/2)) + y_airplane
    #__ y = y_airplane + width
    #print(y,-2*(x-(x_airplane+width/2)) + y_airplane)
    if y > -2*(x-(x_airplane+width/2)) + y_airplane and y< y_airplane + width and y > 2*(x-(x_airplane+width/2)) + y_airplane :
        r,g,b=255,255,255
#    elif y > 2*(x-(x_airplane+width/2)) + y_airplane and y < y_airplane + width:
#        r,g,b=255,255,255
#        #print(x,y)
    return r,g,b



def plot(x_airplane,y_airplane):
    xsize = 1376
    ysize = 768
    width = 50
    with open('plane.pic', 'wb') as f:
        for y in range(0,ysize):
            for x in range(0,xsize):
                r,g,b=0,0,0
                if x in range(x_airplane,x_airplane+width) and y in range(y_airplane,y_airplane+width):
                    r,g,b=plane_plot(x,y,x_airplane,y_airplane,width)

                f.write((b).to_bytes(1, byteorder='little'))
                f.write((g).to_bytes(1, byteorder='little'))
                f.write((r).to_bytes(1, byteorder='little'))
                f.write((0).to_bytes(1, byteorder='little'))
                #x+=10
                #y+=10
                #print(x,y)
            #print('Debug: x = %s' % str(x))
            #break
    os.system("cat ./plane.pic > /dev/fb0")
    pass


main()
