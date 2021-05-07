import cv2 as cv
import numpy as np

img_path_list = [
    'photos/gris.jpg',
    'photos/olive.jpg',
    'photos/rose.jpg',
    'photos/vert.jpg'
]


for id, img_path in enumerate(img_path_list):
    img = cv.imread(img_path)
    height = img.shape[0]
    width = img.shape[1]
    
    scale_percent = 20
    new_width = int(width * scale_percent / 100)
    new_height = int(height * scale_percent / 100)
    output = cv.resize(img, (new_width, new_height))
    imgcopy = output.copy()

    gray = cv.cvtColor(output, cv.COLOR_BGR2GRAY)


    edges = cv.Canny(gray, 50, 150, apertureSize=3)

    # cv.imshow('edges', edges)
    lines = cv.HoughLines(edges, 1, np.pi / 180, 110)
    # cv.imshow('lines', lines)
    vertical_lines = []
    horizontal_lines = []
    y2s = []

    coeffs = set([])
    parallel_lines = {}
    for line in lines:
        rho,theta = line[0]

        a = np.cos(theta)
        b = np.sin(theta)
        x0 = a*rho
        y0 = b*rho
        x1 = int(x0 + 1000*(-b))
        y1 = int(y0 + 1000*(a))
        x2 = int(x0 - 1000*(-b))
        y2 = int(y0 - 1000*(a))

        
        # coeffs.add(a)
        # parallel_lines[a * 100].append(b)
        # if vertical
        if theta > 3:
            a = (y2 - y1)/(x2 - x1)
            b = -a * x1 + y1
            h1 = (-b+0)/a
            h2 = (-b+height)/a
            
            vertical_lines.append(int((h1 + h2)//2))
            # cv.line(imgcopy,(x1,y1),(x2,y2),(0,0,255),2)
        elif theta > 1.5 and theta < 1.6:
            horizontal_lines.append((y2 - y1)//2 + y1)
            y2s.append(y2)
            cv.line(imgcopy,(x1,y1),(x2,y2),(0,0,255),2)

        
    print(parallel_lines)
    cv.imshow('lines', imgcopy)
    # xmin = max(vertical_lines)

    # horizontal_lines.sort()
    # print(sorted(y2s))
    # cropped = img[horizontal_lines[2]:horizontal_lines[-1], xmin:width]
    # cv.imshow('Cropped', cropped)

    # ret,th1 = cv.threshold(cropped,127,255,cv.THRESH_BINARY_INV)
    # cv.imshow('Threshold', th1)

    # cv.imwrite('results/' + str(id) + '.jpg', th1)


    cv.waitKey(0)