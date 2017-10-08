function [ imRGB ] = transformYIQ2RGB( imYIQ )
% transform an image file in a YIQ format to RGB format and returns the
% image.
% the method here is the same as in function transformRGB2YIQ 
%the only difference is that here i used the inverse numbers matrix
%because here we want to change the Y I Q values to R G B values which is
%the opposite from what we want in transformRGB2YIQ.

if( isa(imYIQ, 'integer'))
    imYIQ = double(imYIQ) / 255.0;
end

imSize = size(imYIQ);
height = imSize(1);
width = imSize(2);

imVector = reshape(imYIQ, height * width, 3);
imVector = repmat(imVector, 1, 3);

imVector  = reshape(imVector', 3, 3 * height * width)';

numberMatrix = [0.299 0.587 0.114; 0.596 -0.275 -0.321; ...
    0.212 -0.523 0.311];
numberMatrix = inv(numberMatrix);

numbersVector = repmat(numberMatrix, height * width, 1);

resultVector =  imVector .* numbersVector;
resultVector = sum(resultVector, 2);

imRGB = reshape(resultVector, 3, width * height)';
imRGB = reshape(imRGB, imSize);
end

