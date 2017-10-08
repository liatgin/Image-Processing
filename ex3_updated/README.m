liat_gin
README 
  
matlab version: R2012a
plattform: Windows 7 64 bit
list of files:

imReadAndConvert.m - function from ex1 
GaussianPyramid.m - build a gaussian pyramid to a given image. 
LaplacianPyramid.m - build a laplacian pyramid to a given image. 
LaplacianToImage.m - reconstruct an image by getting its laplacian pyramid.
renderPyramid.m - make a representation of the pyramyd in one image.  
displayPyramid.m - display a given pyramid by the result of renderPyramid. 
pyramidBlending.m - blending between 2 images by their lapalacian pyramids.

blendingExample1.m - blending 2 pictures: a baby in costume + Muhamad Abu Tir 
                     into Abu tir inside the baby costume. 
i1.jpg
i2.jpg
mask.jpg

blendingExample2.m -  blending 2 pictures: a unicorn + blue flame into flame unicoorn.
horse.jpg
fire.jpg
mas3.jpg

Expand.m - expand image with a given filter. by zerro padding, up sample and blurring
README - this file 

answer on question from 3.2:
-----------------------------
1) The laplacian pyramid contains the middle freqencies of the image. 
   So, if we multiply the biggest image with large scalar we will 
   give more intensity to the high frequncies (among the middle freqencies).
   if we multiply the smallest image with large scalar we will give more 
   intensity to the lower frequncies (among the middle freqencies).
   In the fourier space it is equivelent to multiply with band pass filter.


answer on question from 4.2.1:
-------------------------------
1) filterSizeIm = 1 : the result blending will be bad because we did not
   perform blurr on the images
   
2) filterSizeIm = 3 : the result will look better than no blending at 
   all because we perform now blurring with small filter.
   
3) filterSizeIm = 5 : the result will be good because we took a larger 
   kernel size.
   
4) filterSizeIm = 7 : the blending will be very good -will look smoother
   because we blurr the pictures with large filter.
   
   the higher the filter size is the better the blending looks.


answer on question from 4.2.2:
-------------------------------
The more pyramid levels we blend, the more different frequencies we blend
and the more seamless the blending looks. When using big filters and many
levels of pyramids, the edges becomes a problem and the smaller
pyramid levels are nothing to do with the images and the blending 
becomes less effective.


