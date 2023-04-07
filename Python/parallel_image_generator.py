# -*- coding: utf-8 -*-
import numpy as np
import cv2
#img = cv2.imread("road_10_gray.bmp")

#cv2.imwrite("gray.bmp", img)

#cv2.imshow('image',a)
#cv2.waitKey(0)
#cv2.destroyAllWindows()


def generate_parallel_images(img):
    #write gray image
    cv2.imwrite('parallel_images/road_gray.bmp',img)
    #shift 1 bit down
    a = np.zeros(img.shape)
    for i in range(1, len(img)):
        for j in range(len(img[i])):
            for k in range(len(img[i][j])):
                #print(img[i][j][k])
                a[i-1][j][k] = img[i][j][k]

    cv2.imwrite('parallel_images/down.bmp', a)

    #shift 1 bit up
    a = np.zeros(img.shape)
    for i in range(len(img)-1):
        for j in range(len(img[i])):
            for k in range(len(img[i][j])):
                #print(img[i][j][k])
                a[i+1][j][k] = img[i][j][k]

    cv2.imwrite('parallel_images/up.bmp', a)
    
        #shift 1 bit left
    a = np.zeros(img.shape)
    for i in range(len(img)):
        for j in range(1, len(img[i])):
            for k in range(len(img[i][j])):
                #print(img[i][j][k])
                a[i][j-1][k] = img[i][j][k]

    cv2.imwrite('parallel_images/left.bmp', a)

    #shift 1 bit right
    a = np.zeros(img.shape)
    for i in range(len(img)):
        for j in range(len(img[i])-1):
            for k in range(len(img[i][j])):
                #print(img[i][j][k])
                a[i][j+1][k] = img[i][j][k]

    cv2.imwrite('parallel_images/right.bmp', a)

    #shift 1 bit down 1 bit left
    a = np.zeros(img.shape)
    for i in range(1, len(img)):
        for j in range(1, len(img[i])):
            for k in range(len(img[i][j])):
                #print(img[i][j][k])
                a[i-1][j-1][k] = img[i][j][k]

    cv2.imwrite('parallel_images/leftdown.bmp', a)
            
    #shift 1 bit up
    a = np.zeros(img.shape)
    for i in range(len(img)-1):
        for j in range(len(img[i])-1):
            for k in range(len(img[i][j])):
                #print(img[i][j][k])
                a[i+1][j+1][k] = img[i][j][k]

    cv2.imwrite('parallel_images/rightup.bmp', a)

    #shift 1 bit left
    a = np.zeros(img.shape)
    for i in range(len(img)-1):
        for j in range(1, len(img[i])):
            for k in range(len(img[i][j])):
                #print(img[i][j][k])
                a[i+1][j-1][k] = img[i][j][k]

    cv2.imwrite('parallel_images/leftup.bmp', a)

    #shift 1 bit right
    a = np.zeros(img.shape)
    for i in range(1, len(img)):
        for j in range(len(img[i])-1):
            for k in range(len(img[i][j])):
                #print(img[i][j][k])
                a[i-1][j+1][k] = img[i][j][k]

    cv2.imwrite('parallel_images/rightdown.bmp', a)