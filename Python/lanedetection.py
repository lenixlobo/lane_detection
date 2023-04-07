import cv2
import numpy as np
from PIL import Image, ImageTk
import tkinter as tk
from tkinter import ttk, messagebox
import tkinter.filedialog as fd
import parallel_image_generator as pig
import houghtransform as ld

#Create root window
root = tk.Tk()
root.title('Lane Detection')
root.resizable(False, False)
root.geometry('600x600')


#Create a class which handles all methods required for our operations
class ImageHandler:
    def __init__(self, filename=None, image=None, imagelabel=None):
        self.filename = filename
        self.image = image
        self.imagelabel = tk.Label(root)
        self.imagelabel.pack()

    # select_image : Asks user for the bmp image of choice, and displays it on a window
    # Once a image is loaded, a button called "Generate parallel images" is instantiated.
    def select_image(self):
        filetypes = [('Image files', '.bmp')]
        self.filename = fd.askopenfilename(filetypes=filetypes, title='Open image')
        self.image = cv2.imread(self.filename)
        #Display the Opened image
        tkimg = ImageTk.PhotoImage(Image.fromarray(cv2.cvtColor(self.image, cv2.COLOR_BGR2RGB)))
        self.imagelabel.image = tkimg
        self.imagelabel.configure(image = tkimg)
        
    #Generates and store gray colored pixel shifted images in parallel_images/
    #These images are used by the Vivado project
    def generate_parallel_values(self):
        if(self.image is None):
            messagebox.showinfo('Error', 'Select image first')
            return
        image_gray = cv2.cvtColor(self.image, cv2.COLOR_BGR2GRAY)
        image_gray = cv2.cvtColor(image_gray, cv2.COLOR_GRAY2BGR)
        pig.generate_parallel_images(np.array(image_gray))
        messagebox.showinfo('Info', 'Parallel images generated in parallel_images/')
    
    #Calls the opencv pipeline which implements the Hough transform logic
    def detectlines(self):
        if(self.image is None):
            messagebox.showinfo('Error', 'Select image first')
            return
        print("Filename : " + self.filename)
        ld.dolinedetection(self.filename)

    def reset(self):
        self.filename = None
        self.image = None
        self.imagelabel.image = None

#init class
imghandler = ImageHandler()
#Create a button to Open Image
openbutton = ttk.Button(root, text='Open Image', command=imghandler.select_image)
openbutton.place(x=0, y=0)

#Create a button to generate parallel images for Sobel
parallelprocess = ttk.Button(root, text='Generate parallel images', command = imghandler.generate_parallel_values)
parallelprocess.place(x=235, y=470)

#Do Hough transform here
houghbutton = ttk.Button(root, text='Detect Lines', command=imghandler.detectlines)
houghbutton.place(x=255, y=500)

#Create a close button to Close the window
closebutton = ttk.Button(root, text='Close Window', command=root.quit)
closebutton.place(x=510, y=0)

root.mainloop()
