function [pyr, filter] = LaplacianPyramid(im, maxLevels, filterSize)

% calculates the gaussian pyramid
 [gaussianPyr, filter] = GaussianPyramid(im, maxLevels, filterSize); 
    
 lPyrSize = size(gaussianPyr);
 lPyrSize = lPyrSize(1);   
    
 %initialize the laplacian pyramid  
 laplacianPyr = cell(lPyrSize, 1);
 laplacianPyr{lPyrSize} = gaussianPyr{lPyrSize};
 
 %calculate the laplacian pyramid
 for i = (lPyrSize - 1):-1:1
   [expandIm] = Expand(gaussianPyr{i + 1}, filter);
   
   L_i = gaussianPyr{i} - expandIm;
   laplacianPyr{i, 1} = L_i;

 end
 
 pyr = laplacianPyr;

end