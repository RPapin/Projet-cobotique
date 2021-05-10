from scipy.spatial import distance as dist
from imutils import perspective
from imutils import contours
import argparse
import imutils
import cv2
import numpy as np
import math
from houghbundler import HoughBundler
from statistics import *

img_path_list = [
  'plan_experience/1.png',
  'plan_experience/2.png',
  'plan_experience/3.png',
  'plan_experience/4.png'
]

for img_path in img_path_list:
  # Read image 
  not_resized_img = cv2.imread(img_path, cv2.IMREAD_COLOR)
  not_resized_img_height = not_resized_img.shape[0]
  not_resized_img_width = not_resized_img.shape[1]
  scale_percent = 30
  new_height = int(not_resized_img_height * scale_percent / 100)
  new_width = int(not_resized_img_width * scale_percent / 100)
  img = cv2.resize(not_resized_img, (new_width, new_height))

  # Convert the image to gray-scale
  gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
  ret, thresh1 = cv2.threshold(gray,140,255,cv2.THRESH_BINARY)
  # cv2.imshow("Result Image", thresh1)
  # kernel_size = 5
  # blur_gray = cv2.GaussianBlur(gray,(kernel_size, kernel_size),0)

  # Find the edges in the image using canny detector
  low_threshold = 50
  high_threshold = 200
  # edges = cv2.Canny(blur_gray, low_threshold, high_threshold, apertureSize=3)

  rho = 1  # distance resolution in pixels of the Hough grid
  theta = np.pi / 180  # angular resolution in radians of the Hough grid
  threshold = 50  # minimum number of votes (intersections in Hough grid cell)
  min_line_length = 200  # minimum number of pixels making up a line
  max_line_gap = 8  # maximum gap in pixels between connectable line segments
  line_image = np.copy(img) * 0  # creating a blank to draw lines on
  line_image_2 = np.copy(img) * 0  # creating a blank to draw lines on
  line_image_3 = np.copy(img) * 0  # creating a blank to draw lines on

  # Run Hough on edge detected image
  # Output "lines" is an array containing endpoints of detected line segments
  houghP_lines = cv2.HoughLinesP(thresh1, rho=rho, theta=theta, threshold=threshold, minLineLength=min_line_length, maxLineGap=max_line_gap)

  for line in houghP_lines:
    for x1,y1,x2,y2 in line:
      cv2.line(line_image,(x1,y1),(x2,y2),(0,255,0),2)

  # cv2.imshow('lines', line_image)
  # cv2.waitKey(0)

  a = HoughBundler()
  processed_lines = a.process_lines(houghP_lines, thresh1)

  for line in processed_lines:
    cv2.line(line_image_2,(line[0][0], line[0][1]), (line[1][0], line[1][1]),(0,255,0),2)

  # cv2.imshow('lines_2', line_image_2)
  # cv2.waitKey(0)

  # print(len(processed_lines))
  ys = []
  ys_diff = []

  for line in processed_lines:
    # image, start_point, end_point, color, thickness
    # cv2.line(line_image, (line[0][0], line[0][1]), (line[1][0], line[1][1]), (255,0,0), 5)
    ys.append((line[0][1] + line[1][1]) / 2)

  mid_height = new_height // 2
  for y in ys:
    ys_diff.append(abs(mid_height - y))

  ys_diff_sorted = sorted(ys_diff)[:9]

  x_min = 9999
  x_max = 0
  y_min = 9999
  y_max = 0
  for y_diff_sorted in ys_diff_sorted:
    line = processed_lines[ys_diff.index(y_diff_sorted)]
    cv2.line(line_image_3, (line[0][0], line[0][1]), (line[1][0], line[1][1]), (255,0,0), 5)
    current_x_min = min(line[0][0], line[1][0])
    current_x_max = max(line[0][0], line[1][0])
    current_y_min = min(line[0][1], line[1][1])
    current_y_max = max(line[0][1], line[1][1])
    x_min = current_x_min if current_x_min < x_min else x_min
    x_max = current_x_max if current_x_max > x_max else x_max
    y_min = current_y_min if current_y_min < y_min else y_min
    y_max = current_y_max if current_y_max > y_max else y_max
    
  # Draw the lines on the  image
  # src1, alpha, src2, beta, 0.0
  lines_edges = cv2.addWeighted(img, 0.2, line_image_3, 0.8, 0)
  # cv2.imshow('lines_edges', lines_edges)
  # cv2.waitKey(0)
  
  # crop around our 9 lines
  padding = 50
  crop_img = img[y_min-padding:y_max+padding, x_min-padding:x_max+padding]
  # Show result
  # cv2.imshow("Result Image", crop_img)
  # cv2.waitKey(0)

  gray = cv2.cvtColor(crop_img, cv2.COLOR_BGR2GRAY)
  ret,thresh = cv2.threshold(gray,140,255,0)
  # cv2.imshow("Result Image", thresh)
  # cv2.waitKey(0)

  cnts,hierarchy = cv2.findContours(thresh, 1, 2)
  # cv2.drawContours(crop_img, c, -1, (0,255,0), 1)
  current_index = -1
  degrees = []
  for index, c in enumerate(cnts):
    if cv2.contourArea(c) < 1500:
      continue
    current_index += 1
    if current_index == 0:
      continue

    cv2.drawContours(crop_img, cnts, index, (0,255,0), 1)
    extLeft = tuple(c[c[:, :, 0].argmin()][0])
    extRight = tuple(c[c[:, :, 0].argmax()][0])
    adjacent = extRight[0] - extLeft[0]
    oppose = extRight[1] - extLeft[1]
    hypotenuse = math.sqrt(adjacent**2 + oppose**2)
    degrees.append(math.atan(oppose / adjacent))
    # x,y,w,h = cv2.boundingRect(c)
    # cv2.putText(crop_img, str(w), (x,y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (36,255,12), 2)
    # cv2.rectangle(crop_img, (x, y), (x + w, y + h), (36,255,12), 1)
  correction_angle = math.degrees(mean(degrees))

  # cv2.imshow("Result Image", crop_img)
  # cv2.waitKey(0)

  rotated = imutils.rotate(crop_img, correction_angle)

  gray = cv2.cvtColor(rotated, cv2.COLOR_BGR2GRAY)
  ret,thresh = cv2.threshold(gray,140,255,0)

  cnts,hierarchy = cv2.findContours(thresh, 1, 2)
  # cv2.drawContours(crop_img, c, -1, (0,255,0), 1)
  
  current_index = -1
  lines_height = []
  
  for index, c in enumerate(cnts):
    if cv2.contourArea(c) < 1500:
      continue
    current_index += 1
    if current_index == 0:
      continue
    
    top = []
    bot = []
    latest_x = None
    for [[x,y]] in c:
      print(x, y)

    # cv2.drawContours(rotated, cnts, index, (0,255,0), 1)
    # extLeft = tuple(c[c[:, :, 0].argmin()][0])
    # extRight = tuple(c[c[:, :, 0].argmax()][0])
    # adjacent = extRight[0] - extLeft[0]
    # oppose = extRight[1] - extLeft[1]
    # hypotenuse = math.sqrt(adjacent**2 + oppose**2)
    # degrees.append(math.atan(oppose / adjacent))
    x,y,w,h = cv2.boundingRect(c)
    lines_height.append((y + y + h) / 2)
    # cv2.putText(rotated, str(h), (x,y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (36,255,12), 2)
    # cv2.rectangle(rotated, (x, y), (x + w, y + h), (36,255,12), 1)

  height_diffs = []
  for index, line_height in enumerate(lines_height):
    if index == 7:
      continue
    height_diffs.append((line_height + lines_height[index + 1]) / 2)

  pixels_by_millimeter = mean(height_diffs) / 42

  current_index = -1
  for index, c in enumerate(cnts):
    if cv2.contourArea(c) < 1500:
      continue
    current_index += 1
    if current_index == 0:
      continue

    x,y,w,h = cv2.boundingRect(c)
    cv2.putText(rotated, "%.2f" % (h / pixels_by_millimeter), (x,y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (36,255,12), 2)
    cv2.rectangle(rotated, (x, y), (x + w, y + h), (36,255,12), 1)

  cv2.imshow("Result Image", rotated)
  cv2.waitKey(0)