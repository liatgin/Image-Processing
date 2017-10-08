function pyr = createPyramid(im)
% CREATEPYRAMID Create a pyramid from the input image, where pyr{1} is the smallest level,
% pyr{4} is the input image, and pyr{5},pyr{6},pyr{7} are zeros.
% The ratio between two adjacent levels in the pyramid is 2(1/3).
% Arguments:
% im - a grayscale image
% outputs:
% pyr - A 7 ª 1 cell of matrices.

%note: maybe should change the size of the pyramids and use round
%pyr = {};
%pyr{4} =  im;
%pyr{3} =  imresize(pyr{4}, 1 / (2 ^ (1/3)), 'cubic');
%pyr{2} =  imresize(pyr{3}, 1 / (2 ^ (1/3)), 'cubic'); 
%pyr{1} =  imresize(pyr{2}, 1 / (2 ^ (1/3)), 'cubic');
%pyr{5} = imresize(pyr{4}, (2 ^ (1/3)), 'cubic');
%pyr{6} = imresize(pyr{5}, (2 ^ (1/3)), 'cubic');
%pyr{7} = imresize(pyr{6}, (2 ^ (1/3)), 'cubic');
%[r5, c5] = size(pyr{5});
%[r6, c6] = size(pyr{6});
%[r7, c7] = size(pyr{7});
%pyr{5} = zeros(r5, c5/3, 3);
%pyr{6} = zeros(r6, c6/3, 3);
%pyr{7} = zeros(r7, c7/3, 3);


pyr{4} = im;
    ratio = 2 ^ (1/3);
    
    % smaller images
    for i = [3: -1 : 1]
        pyr{i} = imresize(im, 1 / ratio ^ (4 - i), 'cubic');
    end
    [r,c] = size(im);

    % black bigger images
    pyr{5} = zeros(round(r * ratio), round(c * ratio));
    pyr{6} = zeros(round(r * (ratio ^ 2)), round(c * (ratio ^ 2)));
    pyr{7} = zeros(round(r * (ratio ^ 3)), round(c * (ratio ^ 3)));
 
end