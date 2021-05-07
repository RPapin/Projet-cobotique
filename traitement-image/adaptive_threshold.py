import cv2
import numpy as np
from matplotlib import pyplot as plt

img_path_list = [
  'plan_experience/1.png',
  # 'plan_experience/2.png',
  # 'plan_experience/3.png',
  # 'plan_experience/4.png'
]

for img_path in img_path_list:

  not_resized_img = cv2.imread(img_path,0)
  not_resized_img_height = not_resized_img.shape[0]
  not_resized_img_width = not_resized_img.shape[1]
  scale_percent = 30
  new_height = int(not_resized_img_height * scale_percent / 100)
  new_width = int(not_resized_img_width * scale_percent / 100)
  img = cv2.resize(not_resized_img, (new_width, new_height))
  img = cv2.medianBlur(img,5)
  ret,th1 = cv2.threshold(img,140,255,cv2.THRESH_BINARY)
  # th2 = cv2.adaptiveThreshold(img,255,cv2.ADAPTIVE_THRESH_MEAN_C,\
  #             cv2.THRESH_BINARY,11,2)
  # th3 = cv2.adaptiveThreshold(img,255,cv2.ADAPTIVE_THRESH_GAUSSIAN_C,\
  #             cv2.THRESH_BINARY,11,2)

  # nimp,th4 = cv2.threshold(th3,127,255,cv2.THRESH_BINARY)
  th2 = th1.copy()
  # th1 = cv2.cvtColor(th1,cv2.COLOR_BGR2GRAY)
  th2 = cv2.cvtColor(th2, cv2.COLOR_BGR2RGB)
  edges = cv2.Canny(th1,50,150,apertureSize = 3)

  lines = cv2.HoughLinesP(th1, 1, np.pi/180, 300, minLineLength=10, maxLineGap=250)
  a,b,c = lines.shape
  # print(lines[0])
  for i in range(a):
    rho = lines[i][0][0]
    theta = lines[i][0][1]    
    a = np.cos(theta)
    b = np.sin(theta)
    x0 = a*rho
    y0 = b*rho
    x1 = int(x0 + 1000*(-b))
    y1 = int(y0 + 1000*(a))
    x2 = int(x0 - 1000*(-b))
    y2 = int(y0 - 1000*(a))

    cv2.line(th2,(x1,y1),(x2,y2),(0,0,255),2)

  titles = ['Original Image', 'Global Thresholding (v = 140)',
              'Adaptive Mean Thresholding', 'Adaptive Gaussian Thresholding']
  images = [img, th1, edges, th2]

  for i in range(4):
      plt.subplot(2,2,i+1),plt.imshow(images[i], 'gray' if i < 3 else 'viridis') #,'gray'
      plt.title(titles[i])
      plt.xticks([]),plt.yticks([])
  plt.show()
