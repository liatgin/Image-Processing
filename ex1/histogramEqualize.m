function [ imEq, histOrig, histEq ] = histogramEqualize( imOrig )
%performs histogram equalization of a given grayscale or RGB image.
%The function also displies the input and the equalized output image.

sizes = size(imOrig);
dim = size(sizes);

if (dim(2) == 3) && (sizes(3) == 3)
    colorType = 'truecolor';
else
    colorType = 'grayscale';
end

% is it RGB image
  if (strcmp(colorType, 'truecolor') == 1)
    imYIQ = transformRGB2YIQ(imOrig);
    %operate only on Y channel
    yChannel = imYIQ(:, :, 1);
  else
     yChannel = imOrig; % the image has not changed
  end

% Computes the image histogram
histogram = imhist(yChannel);    

% Computes the cumulative histogram
cumHistogram = cumsum(histogram);

numOfPixels = sum(histogram);

%Normalizes the cumulative histogram (divide by the total number of pixels)
nCumHist = double(cumHistogram) / numOfPixels;

%Multiplies the normalized histogram by the maximal gray level value (K-1)
nCumHist = nCumHist * 255;

%Rounds the values to get integers (use round)
nCumHist = round(nCumHist);

%Map the intensity values of the image using the result of step 5.
yChannel = nCumHist(1 + round(yChannel * 255)); 

yChannel = double(yChannel) / 255;

% Verify that the minimal value is 0 and that the maximal is K-1,
% otherwise stretch the result linearly in the range [0,K-1]
%minGraylevel = min(imOrig);
%maxLevel = max(imOrig);
%if(minGraylevel ~= maxLevel)
 %   yChannel = minGraylevel;
  %  yChannel = ( yChannel) ./ (maxLevel - minGraylevel);
%end


if (strcmp(colorType, 'truecolor') == 1)
    image = imYIQ;
    image(:, :, 1) = yChannel;
    image = transformYIQ2RGB(image);
else
    image = yChannel;
end

imEq = image; 
histOrig =  histogram;
histEq = imhist(yChannel);
figure, imshow(imOrig);
figure, imshow(imEq);
end

