def plane_plot(x,y,x_airplane,y_airplane,width):
    r,g,b=0,0,0
    #print(x,y)
    # / (x_airplane+ width/2,y_airplane), (x_airplane,y_airplane + width)
    # y = -2(x-(x_airplane+ width/2)) + y_airplane

    # \ (x_airplane+ width/2,y_airplane), (x_airplane+width,y_airplane + width)
    # 2*(x-(x_airplane+ width/2)) + y_airplane

    # / y = 2*(x-(x_airplane+width/2)) + y_airplane
    # \ y = -2*(x-(x_airplane+width/2)) + y_airplane
    #__ y = y_airplane + width
    print(y,-2*(x-(x_airplane+width/2)) + y_airplane)
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
            #print('Debug: x = %s' % str(x))
            #break
    pass

plot(600,700)
