  
# importing cv2
import cv2
  
# path
path = 'road_11.bmp'
  
# Reading an image in default mode
image = cv2.imread(path)
  
# Window name in which image is displayed
window_name = 'image'
  
# Using cv2.imshow() method
# Displaying the image
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
print(gray_image.shape)
#cv2.imshow(window_name, gray_image)
cv2.imwrite('grayroad.bmp', gray_image)
# waits for user to press any key
# (this is necessary to avoid Python kernel form crashing)
#cv2.waitKey(0)
  
# closing all open windows
cv2.destroyAllWindows()