function [idx,Dist] = findNearestNeighbors(imPatches, dbPatches)
% FINDNEARESTNEIGHBORS Find the 3 nearest neighbors for each patch in the input images from the patches in the DB
% N represents the number of patches in the DB, and M represents the number of patches in the input image.
% Arguments:
% imPatches - M ª 5 ª 5 matrix with M patches that were sampled from the input image (pyr{4})
% dbPatches - N ª 5 ª 5 matrix with N db patches
% Outputs:
% idx - M ª 3 matrix where the ith row has 3 indices of the 3 patches in the db that are most similar to the ith patch
%from the input image
% Dist- M ª 3 matrix where the ith row contains the euclidean distances between the best 3 patches that has been
%found for the ith patch

%converts each patch to a vector in R25
%M = size(imPatches, 1);
%N = size(dbPatches, 1);
%size(imPatches)
%size(dbPatches)
%imPatches = reshape(imPatches, M, 25); % M x 25
%imPatches(1, :) = imPatches(1, :)';
%dbPatches(1, :) = dbPatches(1, :)';
%dbPatches = reshape(dbPatches, N, 25); % N x 25
%k = 3;
%size(dbPatches)
%size(imPatches)

%[idx,Dist] = knnsearch(dbPatches, imPatches,'k', 3);

%figure, imshow(imPatches(1,:,:));







 k = 3;
        patchSize = 5;
        M = size(imPatches, 1);
        N = size(dbPatches, 1);
        imPatchesFlat = reshape(imPatches, [M, 5 ^ 2]);
        dbPatchesFlat = reshape(dbPatches, [N, 5 ^ 2]);
        [idx, Dist] = knnsearch(dbPatchesFlat, imPatchesFlat, 'K', k);



end