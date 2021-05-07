import cv2
import numpy as np

# load color image
not_resized_img = cv2.imread('plan_experience/3.png')

not_resized_img_height = not_resized_img.shape[0]
not_resized_img_width = not_resized_img.shape[1]
scale_percent = 30
new_height = int(not_resized_img_height * scale_percent / 100)
new_width = int(not_resized_img_width * scale_percent / 100)
im = cv2.resize(not_resized_img, (new_width, new_height))
# im = cv2.imread('plan_experience/1.png')

# smooth the image with alternative closing and opening
# with an enlarging kernel
morph = im.copy()

kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (1, 1))
morph = cv2.morphologyEx(morph, cv2.MORPH_CLOSE, kernel)
morph = cv2.morphologyEx(morph, cv2.MORPH_OPEN, kernel)

kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (2, 2))

# take morphological gradient
gradient_image = cv2.morphologyEx(morph, cv2.MORPH_GRADIENT, kernel)

# split the gradient image into channels
image_channels = np.split(np.asarray(gradient_image), 3, axis=2) #

channel_height, channel_width, _ = image_channels[0].shape

# apply Otsu threshold to each channel
for i in range(0, 3):
    _, image_channels[i] = cv2.threshold(~image_channels[i], 0, 255, cv2.THRESH_OTSU | cv2.THRESH_BINARY)
    image_channels[i] = np.reshape(image_channels[i], newshape=(channel_height, channel_width, 1))

# merge the channels
image_channels = np.concatenate((image_channels[0], image_channels[1], image_channels[2]), axis=2)

# save the denoised image
cv2.imshow('output', image_channels)
cv2.waitKey(0)
# cv2.imwrite('output.jpg', image_channels)