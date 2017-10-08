function [ imYIQ ] = transformRGB2YIQ(imRGB)
%transform RGB image file to YIQ format and returns the image.
% in order to operate on the r g b values of all the pixels
% i reshaped the matrix into one vector that contains all the 
%rgb values of any pixel and  another vector (in the same size) 
%that contains the appropriate values from the matrix of the numbers so 
% i could use the .* operator and got the wishful y i q values.
% then i reshaped the result vector to matrix shape.


if( isa(imRGB, 'integer'))
    imRGB = double(imRGB) / 255.0;
end

imSize = size(imRGB);
height = imSize(1);
width = imSize(2);

imVector = reshape(imRGB, [height * width, 3]);
imVector = repmat(imVector, 1, 3);


imVector  = reshape(imVector', 3, 3 * height * width)';

numberMatrix = [0.299 0.587 0.114; 0.596 -0.275 -0.321; ...
    0.212 -0.523 0.311];

numbersVector = repmat(numberMatrix, height * width, 1);

resultVector =  imVector .* numbersVector;
resultVector = sum(resultVector, 2);

imYIQ = reshape(resultVector, 3, width * height)';
imYIQ = reshape(imYIQ, imSize);

end

