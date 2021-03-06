function [p_x, p_y, patches] = samplePatches(im, border)
% SAMPLEPATCHES Sample 5 � 5 patches from the input image. You are allowed to use 2D loops here.
% Arguments:
% im - a grayscale image of size m � n
% border ? An integer that determines how much border we want to leave in the image. For example: if border=0 the
%center of the first patch will be at (3,3), and the last one will be at (end?2,end?2), so the number of patches in this
%case is (m - 4) � (n - 4). But if border=1 the center of the first patch will be at (4,4) and the last one will be at (
%end-3,end-3). So in general, the number of patches is (m - 2 � (2 + border)) � (n - 2 � (2 + border)).
%
% outputs:
% p_x - (m - 2 � (2 + border)) � (n - 2 � (2 + border)) matrix with the x indices of the centers of the patches
% p_y - (m - 2 � (2 + border)) � (n - 2 � (2 + border)) matrix with the y indices of the centers of the patches
% patches- (m - 2 � (2 + border)) � (n - 2 � (2 + border)) � 5 � 5 the patches

%[r, c] = size(im);
%from left to right
%cornersUp = [[3 + border, 3 - border], [3 + c - 2 - border , 3 + border]];
%cornersDown = [[3 + border, 3 + r - 2 - border], [3 + c - 2 - border, 3 + border + r - 2]];
%patches = [];
%rows = 3 + c - 2 - border - (3 + border) + 1;         % c - 1 - border
%cols = 3 + r - 2 - border - (3 - border) + 1;         % r - 1 
%ind1 = 1; % 1
%ind2 = 1; % 1
%for i = 3 : rows - 3
    %for j = 3 : cols - 3       
       % p_x(i, j) = j;  % 1X1 
      %  p_y(i, j) = i;  % 1X1
     %   currPatch = findPatch(im, i, j); % 5X5
        % (m - 2 � (2 + border)) � (n - 2 � (2 + border)) � 5 � 5
    %    patches(i, j, :, :) = currPatch;    
   %     ind2 = ind2 + 1;
  %  end
 %   ind1 = ind1 + 1;

%end
%end

%function [patch]= findPatch(im, indexRow, indexCol)
%    patch = im(indexCol - 2: indexCol + 2,indexRow - 2 : indexRow + 2); % 5X5
%end




   patchRad = 2;
    patchSize = 2 * patchRad + 1;
    im = repmat(im, [1,1,patchSize]);
    % boost performance
    [origRows, origCols] = size(im);

    r = origRows - 2 * (border + patchRad);
    c = origCols - 2 * (border + patchRad);
    
    patches = zeros(r, c, patchSize, patchSize);


    % note to self: unloop if slow
    for i = 1: patchSize
        for j = 1: patchSize
            patches(:, :, i, j) = im(i + border : r + i + border - 1, j + border : c + border + j - 1);
        end
    end
    [p_x, p_y] = meshgrid(border + patchRad + 1 : border + patchRad + c,...
                          border + patchRad + 1 : border + patchRad + r);
end


