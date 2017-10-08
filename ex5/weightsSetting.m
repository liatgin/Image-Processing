function [weights] = weightsSetting( imPatches, Dists, pyr ,dbPatchesStd )
% WEIGHTSSETTING Given 3 nearest neighbors for each patch of the input image
% Find a threshold (maximum distance) for each input patch.
% Next, give a weight for each candidate based on its distance from the input patch.
% denote m,n such that [m,n]=size(pyr{4})
% Arguments:
% imPatches - (m - 4) ª (n - 4) ª 5 ª 5 matrix with the patches that were sampled from the input image (pyr{4})
% Dists - (m - 4) ª (n - 4) ª 3 matrix with the distances returned from findNearestNeighbors.
% pyr - 7 ª 1 cell created using createPyramid
% dbPatchesStd - (m - 4) ª (n - 4) ª 3 matrix with the STDs of the neighbors patches returned from
% findNearestNeighbors.
% Outputs:
% weights - (m - 4) ª (n - 4) ª 3 matrix with the weights for each DB candidates

% use translateImageHalfPixel()
%[translatedInX, translatedInY] = translateImageHalfPixel(pyr{4});
%sample patches from each image using samplePatches with border = 0
% p_x_1 and p_y_1 is (m - 2 · (2 + border)) ª (n - 2 · (2 + border))
%[p_x_1, p_y_1, patchesTransX] = samplePatches(translatedInX, 0); 
% p_x_2 and p_y_2 is (m - 2 · (2 + border)) ª (n - 2 · (2 + border))
%[p_x_2, p_y_2, patchesTransY] = samplePatches(translatedInY, 0); 

%calc the euclidean distance between each input patch to its two translated versions
%imPatches = reshape(imPatches, size(imPatches, 1) * size(imPatches, 2), 1, 25);         %(m*n) x 1 x 25
%patchesTransX = reshape(patchesTransX, size(patchesTransX, 1) * size(patchesTransX, 2), 1, 25); %(m*n) x 1 x 25
%distances1 = sqrt(sum((imPatches - patchesTransX).^ 2, 3)); %(m*n) x 1 x 25
%size(imPatches)
%size(patchesTransX)
%size(patchesTransY)
%patchesTransY = reshape(patchesTransY, size(patchesTransY, 1) * size(patchesTransY, 2), 1, 25); %(m*n) x 1 x 25
%distances2 = sqrt(sum((imPatches - patchesTransY).^ 2 , 3)); %(m*n) x 1 x 25

% set the threshold to be the avg between the euclidean distance
% of the current patch the the same patch in translated x and translate y
%threshold = (distances1 + distances2) / 2;
%weights = exp(-(Dists .^ 2) ./ (dbPatchesStd));
%size(Dists(:,:,3))
%size(threshold)
%size(weights(:,:,3))
%D = reshape(Dists(:,:,3),size(threshold, 1), 1);
%W = reshape(weights(:,:,3),size(threshold, 1), 1);
%res = W .* (D >= threshold);
%[r, c] = size(weights(:,:,3));
%weights(:,:,3) = reshape(res, r, c) ;




    [translatedX, translatedY] = translateImageHalfPixel(pyr{4});
    
    [p_x, p_y, translatedXPatches] = samplePatches( translatedX , 0 );
    [p_x, p_y, translatedYPatches] = samplePatches( translatedY , 0 );

    normX = sqrt(sum(sum((imPatches - translatedXPatches).^ 2, 3), 4));
    normY = sqrt(sum(sum((imPatches - translatedYPatches).^ 2, 3), 4));

    threasholds = (normX + normY) ./ 2;

    weights = exp(-(Dists .^ 2) ./ dbPatchesStd);
    weights(:,:,3) = weights(:,:,3) .* (Dists(:,:,3) >= threasholds);







end