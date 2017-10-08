function [] = imDisplay( filename, representation)
% display a given imagefile in a given representation.
image = imReadAndConvert(filename, representation);
impixelinfo(imshow(image));
end

