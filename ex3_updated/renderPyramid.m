function [res] = renderPyramid(pyr, levels)


[imRows, imCols] = size(pyr{1});

sizes = 0.5 .^ [0: levels - 1];

% the size of cols in the final image
totalCols = sum(imCols .* sizes); 

im = zeros(imRows, totalCols);

shift = 1 ;

for i = 1:length(pyr) - 1
    p = pyr{i}; 
    pMin = min(p(:));
    pMax = max(p(:));
    pyr{i} = (pyr{i} - pMin) ./ (pMax - pMin);
end


for i = 1 : levels
    sizePyr_i = size(pyr{i});
    sizeR = sizePyr_i(1) - 1;
    sizeC = sizePyr_i(2);
    im(1 :  sizeC, shift : shift + sizeR ) = pyr{i};
    
    shift = shift + sizeC;
end
res = im;
end