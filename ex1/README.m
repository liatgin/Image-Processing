liat_gin
README 
  
matlab version: R2012a
plattform: Windows 7 64 bit
list of files:

imReadAndConvert.m
imDisplay.m
transformRGB2YIQ.m
transformYIQ2RGB.m
histogramEqualize.m
quantizeImage.m

2 pictures that you asked for:

testImg1.jpg
testImg2.jpg

list of functions:
 
- imReadAndConvert: 

reads a given image file and converts it into a given representation when
representation 1 means grayscale image and representation 2 means RGB image

- imDisplay:

display a given image file in a given representation.

- transformRGB2YIQ:

 transform RGB image file to YIQ format and returns the image.
 in order to operate on the r g b values of all the pixels
 i reshaped the matrix into one vector that contains all the 
 rgb values of any pixel and  another vector (in the same size) 
 that contains the appropriate values from the matrix of the numbers so i
 could use the .* operator and got the wishful y i q values. 
 then i reshaped the result vector to matrix shape.

-transformYIQ2RGB:

transform an image file in a YIQ format to RGB format and returns the
image. the method here is the same as in function transformRGB2YIQ the 
only difference is that here i used the inverse numbers matrix because
here we want to change the y i q values to r g b values which is the 
opposite from what we want in transformRGB2YIQ.

-histogramEqualize:

performs histogram equalization of a given grayscale or RGB image. 
The function also displies the input and the equalized output image.

-quantizeImage:

performs optimal quantization of a given grayscale or RGB image. 



answer on question from 3.5:

The reason for procedure crashing in case of division of z`s will 
have a grey level segment with no pixels,is because the formula of 
calculate q`s contains division in the total number of pixels in a given
segment of z(i) to z(i+1).
Therefore if the total number of pixels in this segment is 0 the division
will be undefined and the procedure will crash.

The choose of the 2 pictures:

testImg1 involves a lot of colors (it is a picture of the northern lights
in Finland) and therefore it enable to test 
the quanization in really easy way and also the other methods.

testImg2 is a picture of a dog from kind 'shitzu' and i chose this 
picture because there is a grass in the picture with a lot of green 
shades so the equaliziation process can be seen here really nice and 
you can see the grass details after the equalization. Also the dog in
that picture is adorable (isnt it?).




