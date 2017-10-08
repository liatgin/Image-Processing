function [p_x, p_y, levels, patches] = createDB( pyr )
% CREATEDB Sample 5 ª 5 patches from levels 1,2,3 of the input pyramid.
% N represents the number of patches that are found in the three images.
% Arguments:
% pyr - 7 ª 1 cell created using createPyramid
% Outputs:
% p_x - N ª 1 vector with the x coordinates of the centers of the patches in the DB
% p_y - N ª 1 vector with the y coordinates of the centers of the patches in the DB
% levels - N ª 1 vector with the pyramid levels where each patch was sampled
% patches - N ª 5 ª 5 the patches

%levels = [];
%[p_x_1, p_y_1, patches_1] = samplePatches(pyr{1}, 2); 
%N = size(patches_1, 1) * size(patches_1, 2);
%p_x_1 = reshape(p_x_1, N, 1);
%p_y_1 = reshape(p_y_1, N, 1);
%levels =  cat(1, levels, repmat(1, [N, 1]));
%patches_1 = reshape(patches_1, N, 5, 5);

%[p_x_2, p_y_2, patches_2] = samplePatches(pyr{2}, 2);  
%size(patches_2)
%N = size(patches_2, 1) * size(patches_2, 2);
%p_x_2 = reshape(p_x_2, N, 1);
%p_y_2 = reshape(p_y_2, N, 1);
%levels =  cat(1, levels, repmat(2, [N, 1]));
%patches_2 = reshape(patches_2, N, 5, 5);

%[p_x_3, p_y_3, patches_3] = samplePatches(pyr{3}, 2); 
%size(patches_3)
%N = size(patches_3, 1) * size(patches_3, 2);
%p_x_3 = reshape(p_x_3, N, 1);
%p_y_3 = reshape(p_y_3, N, 1);
%levels =  cat(1, levels, repmat(3, [N, 1]));
%patches_3 = reshape(patches_3, N, 5, 5);

%p_x = cat(1, p_x_1, p_x_2, p_x_3);
%p_y = cat(1, p_y_1, p_y_2, p_y_3);
%patches = cat(1, patches_1, patches_2, patches_3);








 border = 2;
    patchSize = 5;
    patches = [];
    p_x = [];
    p_y = [];
    levels = [];

    for i = [1, 2, 3]
        [imPX, imPY, imPatches] = samplePatches(pyr{i} , border);
        N = length(imPX(:));
        p_x = cat(1, p_x, imPX(:));
        p_y = cat(1, p_y, imPY(:));
        levels = cat(1, levels, repmat([i], [N, 1]));
        patches = cat(1, patches, reshape(imPatches, [N, patchSize, patchSize]));
    end

end