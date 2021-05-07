import cv2
import numpy as np
from houghbundler import HoughBundler

# Read image 
not_resized_img = cv2.imread('plan_experience/1.png', cv2.IMREAD_COLOR)
not_resized_img_height = not_resized_img.shape[0]
not_resized_img_width = not_resized_img.shape[1]
scale_percent = 30
new_height = int(not_resized_img_height * scale_percent / 100)
new_width = int(not_resized_img_width * scale_percent / 100)
img = cv2.resize(not_resized_img, (new_width, new_height))

# Convert the image to gray-scale
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
ret, thresh1 = cv2.threshold(gray,140,255,cv2.THRESH_BINARY)
cv2.imshow("Result Image", thresh1)
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

# Run Hough on edge detected image
# Output "lines" is an array containing endpoints of detected line segments
houghP_lines = cv2.HoughLinesP(thresh1, rho=rho, theta=theta, threshold=threshold, minLineLength=min_line_length, maxLineGap=max_line_gap)

# a,b,c = houghP_lines.shape
# for i in range(a):
#   rho = houghP_lines[i][0][0]
#   theta = houghP_lines[i][0][1]    
#   a = np.cos(theta)
#   b = np.sin(theta)
#   x0 = a*rho
#   y0 = b*rho
#   x1 = int(x0 + 1000*(-b))
#   y1 = int(y0 + 1000*(a))
#   x2 = int(x0 - 1000*(-b))
#   y2 = int(y0 - 1000*(a))
#   cv2.line(line_image,(x1,y1),(x2,y2),(0,0,255),2, cv2.LINE_AA)

a = HoughBundler()
processed_lines = a.process_lines(houghP_lines, thresh1)
print(len(processed_lines))
ys = []
ys_diff = []

for line in processed_lines:
  # image, start_point, end_point, color, thickness
  # cv2.line(line_image, (line[0][0], line[0][1]), (line[1][0], line[1][1]), (255,0,0), 5)
  ys.append((line[0][1] + line[1][1]) / 2)

mid_height = new_height // 2
for y in ys:
  ys_diff.append(abs(mid_height - y))

ys_diff_sorted = sorted(ys_diff)

padding = 20
x_min = 9999
x_max = 0
y_min = 9999
y_max = 0
for index, y_diff_sorted in enumerate(ys_diff_sorted):
  if index < 9:
    line = processed_lines[ys_diff.index(y_diff_sorted)]
    cv2.line(line_image, (line[0][0], line[0][1]), (line[1][0], line[1][1]), (255,0,0), 5)
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
lines_edges = cv2.addWeighted(img, 0.2, line_image, 0.8, 0)

# crop around our 9 lines
crop_img = lines_edges[y_min-padding:y_max+padding, x_min-padding:x_max+padding]
# Show result
cv2.imshow("Result Image", crop_img)

cv2.waitKey(0)