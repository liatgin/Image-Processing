function [assignmentPositionsX, assignmentPositionsY, samplingPositionsX, samplingPositionsY] = getSamplingInformation...
(sampleCentersX, sampleCentersY, pyr, inputPatchesCentersX, inputPatchesCentersY, levelsUp)
% GETSAMPLINGINFORMATION
% Get the information for sampling a high resolution image. Pairs of: assignment positions in the high resolution image,
% and sampling positions from the rendered pyramid image
% Arguments:
% sampleCentersX - (m - 4) ª (n - 4) ª 3 matrix with the x coordinates of the center of the high resolution patches in
% the rendered image. This variable should be returned from getSamplingCenters function. (green x locations)
% sampleCentersY - (m - 4) ª (n - 4) ª 3 matrix with the y coordinates of the center of the high resolution patches in
% the rendered image. his variable should be returned from getSamplingCenters function. (green y locations).
% pyr - 7 ª 1 cell created using createPyramid
% inputPatchesCentersX - (m - 4) ª (n - 4) input patches center x coordinates
% inputPatchesCentersY - (m - 4) ª (n - 4) input patches center y coordinates
% levelsUp - integer which tells how much levels up we need to sample the window, from the found patch. In the figure
% the case is levelsUp=1
% Outputs:
% assignmentPositionsX - (m - 4) ª (n - 4) ª 3 ª 5 ª 5 x assignment coordinates in the high resolution image (see
% figure)
% assignmentPositionsY - (m - 4) ª (n - 4) ª 3 ª 5 ª 5 y assignment coordinates in the high resolution image (see
% figure)
% samplingPositionsX - (m - 4) ª (n - 4) ª 3 ª 5 ª 5 x sampling coordinates in the rendered pyramid image (see figure)
% samplingPositionsY - (m - 4) ª (n - 4) ª 3 ª 5 ª 5 y sampling coordinates in the rendered pyramid image (see figure)
%

% Create two coordinate matrices: a 5 ª 5 matrix with x coordinates, and a 5 ª 5 matrix with
% y coordinates that correspond to the higher resolution patch (patch around the rounded values
% of upPixelX,upPixelY, the orange patch in (c) in figure 6). Lets denote these two matrices as:
% assignmentPositionsX and assignmentPositionsY respectively. You should use the function
% meshgrid for that.
%inpLevels = ones(size(inputPatchesCentersX, 1), size(inputPatchesCentersX, 2)) * 4;
%[upPixelX, upPixelY, ~] = transformPointsLevelsUp(inputPatchesCentersX, inputPatchesCentersY, inpLevels, pyr, levelsUp);
%upPixelX = permute(upPixelX , [2, 1]);
%upPixelY = permute(upPixelY, [2, 1]);
 %[x, y] = meshgrid(-2 : 2, -2 : 2);
 %[m, n] = size(inputPatchesCentersX);
 %x = permute(repmat(x, [1, 1, m, n, 3]), [3, 4, 5, 1, 2]);
 %y = permute(repmat(y, [1, 1, m, n, 3]), [3, 4, 5, 1, 2]);

%Subtract upPixelX from the rounded values in assignmentPositionsX and upPixelY from assignmentPositionsY
%(demonsrate in (d) in figure 6). This is the shift of the high resolution patch
%with rounded coordinates from the original non-integer coordinates.
%upPixelX = repmat(upPixelX, [1, 1, 3, 5, 5]);
%upPixelY = repmat(upPixelY, [1, 1, 3, 5, 5]);
%upPixelX = permute(upPixelX, [2, 1, 3, 4, 5]);
%upPixelY = permute( upPixelY, [2, 1, 3, 4, 5]);
%upPixelX = upPixelX + x;
%upPixelY = upPixelY + y;
%assignmentPositionsX = round(upPixelX);
%assignmentPositionsY = round(upPixelY);
%samplePixelsX = repmat(sampleCentersX, [1,1,1,5,5]);
%samplePixelsY = repmat(sampleCentersY, [1,1,1,5,5]);
%samplePixelsX = samplePixelsX + x;
%samplePixelsY = samplePixelsY + y;
%samplingPositionsX = assignmentPositionsX - upPixelX + samplePixelsX;
%samplingPositionsY = assignmentPositionsY - upPixelY + samplePixelsY;







patchRad = 2;
    patchSize = 2 * patchRad + 1;
    [M, N] = size(inputPatchesCentersX);
    
    inputLevels = ones(M, N) * 4;
    [upPixelX, upPixelY, levels] = transformPointsLevelsUp(inputPatchesCentersX, inputPatchesCentersY, inputLevels, pyr, levelsUp);
    
    [X, Y] = meshgrid(-patchRad : patchRad, -patchRad : patchRad);
    X = permute(repmat(X, [1, 1, M, N, 3]), [3,4,5,1,2]);
    Y = permute(repmat(Y, [1, 1, M, N, 3]), [3,4,5,1,2]);
    
    upPixelX = repmat(upPixelX, [1, 1, 3, patchSize, patchSize]);
    upPixelY = repmat(upPixelY, [1, 1, 3, patchSize, patchSize]);
    upPixelX = upPixelX + X;
    upPixelY = upPixelY + Y;
    
    assignmentPositionsX = round(upPixelX);
    assignmentPositionsY = round(upPixelY);

    samplePixelsX = repmat(sampleCentersX, [1,1,1,5,5]);
    samplePixelsY = repmat(sampleCentersY, [1,1,1,5,5]);
    samplePixelsX = samplePixelsX + X;
    samplePixelsY = samplePixelsY + Y;
    
    samplingPositionsX = assignmentPositionsX - upPixelX + samplePixelsX;
    samplingPositionsY = assignmentPositionsY - upPixelY + samplePixelsY;



end