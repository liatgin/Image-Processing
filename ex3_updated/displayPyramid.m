function [] = displayPyramid(pyr, levels)
im = renderPyramid(pyr, levels);
figure, imshow(im);
end