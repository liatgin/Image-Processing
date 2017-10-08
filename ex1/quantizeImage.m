function [imQuant, error] = quantizeImage( imOrig, nQuant, nIter )
%performs optimal quantization of a given grayscale or RGB image.
sizes = size(imOrig);
dim = size(sizes);

% if the image is 3D it means it is a rgb image
if (dim(2) == 3) && (sizes(3) == 3)
    colorType = 'truecolor';
else
    colorType = 'grayscale';
end

% if the pictuer is rgb work only on the y channel (:,:,1)

if (strcmp(colorType, 'truecolor') == 1)
    imYIQ = transformRGB2YIQ(imOrig);
    %operate only on Y channel
    yChannel = (imYIQ(:, :, 1)); % between 0-1 
   
  else
     yChannel = imOrig; % the image has not changed
end

hist = imhist(yChannel); %255 integers between 0-255
cumHist = cumsum(hist); %255 integers ([1] = 0, [255])
cumHist = cumHist';
numOfPixels = sum(hist);


% initialilize the z vector with approximated values
z(1) = 0;
z(nQuant + 1) = 255;
for i = 1 : nQuant - 1
    z(i + 1) = find(cumHist >= round((i / nQuant) * numOfPixels), 1);
end
oldZ = z;
%iterate nIter times and find z`s and q`s. stop when it is congregates or
%when we reach to nIter iterations.
q = (1 : nQuant);
error =  [];  
counter = 1;
while (counter <= nIter)% here is the fix. i added '=' to the inequality
    i = 1;
    while(i <= nQuant)
   
        numbersInInterval = (z(i) : z(i + 1));
        numinator = sum((numbersInInterval)' .* (hist((z(i) + 1) :(z(i+1) + 1))));
        denuminator = sum(hist(z(i) + 1: z(i+1) + 1));
        q(i) = round(numinator ./ denuminator);
        i = i + 1;
    end
    i = 2;
    while(i <= nQuant)
        numinator = q(i - 1) + q(i);
        denuminator = 2;
        z(i) = round(numinator ./ denuminator);
        i = i + 1;
    end
    
    %updating the error vector
    LUT = (1:256);
    newColors = [];
    for i = 1:nQuant
    	newColors = [newColors ones(1, z(i+1)-z(i)) * q(i)];  
    end
    newColors = [0 newColors];
    scaledYChannel = round(yChannel * 255);% ychannel between 0-255
    currImage = changem(scaledYChannel , newColors, (0:255));
    %currImage = currImage * 255;
    matrix = (scaledYChannel - currImage) .^2;
    %yChannel - currImage
    error = [error sum(matrix(:))];
    
    % check converge
     if(counter > 1 && error(counter) >= error(counter - 1))
        error = error(1:end-1);
        break;
     end
     if (isequal(z, oldZ))
        break;
     end
     oldZ = z;
    counter = counter + 1;
end

% changes the image colors to the new quantized colors
    LUT = (1:256);
    for i = 1:nQuant
        LUT(z(i) + 1:z(i + 1) + 1) = q(i);  
    end
    yChannel = round(yChannel * 255);
    yChannel = changem(yChannel, LUT, (0:255));
    yChannel= double(yChannel) / 255;

% if the image is rgb assigns the updated y channel in the image 
if (strcmp(colorType, 'truecolor') == 1)
    imQuant = imYIQ;
    imQuant(:, :, 1) = yChannel;
    imQuant = transformYIQ2RGB(imQuant);
    
else
    imQuant = yChannel;
end       
      figure, imshow(imQuant);
      figure, imshow(imOrig);
      error = error';
      figure, plot(error);
end

