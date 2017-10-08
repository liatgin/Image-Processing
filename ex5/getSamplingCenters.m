function [sampleCentersX, sampleCentersY, renderedPyramid] = getSamplingCenters(xCenters, yCenters, centersPyrLevel...
,pyr, levelsUp)
% GETSAMPLINGCENTERS: Given 3 nearest neighbors for each patch of the input image, from the patches DB,
% find the location of parent patch in the rendered pyramid image
% Arguments:
% xCenters - (m - 4) ª (n - 4) ª 3 matrix with the x coordinates of the closest patches (child patches) to each sampled
% patch from the image
% yCenters - (m - 4) ª (n - 4) ª 3 matrix with the y coordinates of the closest patches (child patches) to each sampled
% patch from the image
% centersPyrLevel - (m - 4) ª (n - 4) ª 3 matrix with the levels of the closest patches to each sampled patch from the
% image
% pyr - 7 ª 1 cell created using createPyramid
% levelsUp - integer which tells how much levels up we need to sample the parent patch, from the found patch. In the
% figure the case is levelsUp = 1.
% Outputs:
% sampleCentersX - (m - 4) ª (n - 4) ª 3 matrix with the x coordinates of the center of the patches in the rendered
% image (the green points in the figure)
% sampleCentersY - (m - 4) ª (n - 4) ª 3 matrix with the y coordinates of the center of the patches in the rendered
% image (the green points in the figure)
% renderedPyramid - a single image containing all levels of the pyramid

% Render the pyramid to one large image using renderPyramidEx5
 renderedPyramid = renderPyramidEx5(pyr);    

% Finds the locations of the centers of the corresponding parent patches in the higher resolution image
% using the supplied function transformPointsLevelsUp. Note that the centers of the parent patches
% do not have integer coordinates.

 %[sampleCentersX, sampleCentersY, levels] = transformPointsLevelsUp(xCenters, yCenters, centersPyrLevel, pyr, levelsUp);

%Use the centers of the parent patches to get their locations in the rendered pyramid
 %shift1Levels = size(pyr{1}, 1);
 %shift2Levels = shift1Levels + size(pyr{2}, 1);
 %shift3Levels = shift2Levels + size(pyr{3}, 1);
 %shift4Levels = shift3Levels + size(pyr{4}, 1);
 %shift5Levels = shift4Levels + size(pyr{5}, 1);
 %shift6Levels = shift5Levels + size(pyr{6}, 1); 
 %shift7Levels = shift6Levels + size(pyr{7}, 1);
    
 %shifts = [shift1Levels ; shift2Levels ; shift3Levels ; shift4Levels ; shift5Levels ; shift6Levels ; shift7Levels];
 %centersPyrLevel = centersPyrLevel + levelsUp;
    
 %sampleCentersX = sampleCentersX + shifts(centersPyrLevel); 
 
 
 
 
    [sampleCentersX, sampleCentersY, levels] = ...
        transformPointsLevelsUp( xCenters, yCenters, centersPyrLevel, pyr, levelsUp);
    
    sizesOfImages = cellfun(@(im) size(im, 2), pyr).';
    xPos = [0, cumsum(sizesOfImages)];
    
    % xPos now contains [0, w1, w1+w2, ...] where w1 is the width of pyr{1} and so on
    centersPyrLevel = centersPyrLevel + levelsUp;
    
    % add the position where the image starts to each sampleCentersX
    % this means if sampleCentersX value was 3, and it is from image 2, now it is w1 + w2 + 3
    sampleCentersX = sampleCentersX + xPos(centersPyrLevel);
    
    renderedPyramid = renderPyramidEx5(pyr);

end
