function [image] = getImage(assignmentPositionsX,assignmentPositionsY,samplingPositionsX,samplingPositionsY,weights...
,emptyHighResImage,renderedPyramid)
% GETIMAGE given an image of the rendered pyrmamid, sampling indices from the rendered pyrmamid, and
% assignment indices in the highres image return a high resolution image
% Arguments:
% assignmentPositionsX - (m - 4) ª (n - 4) ª 3 ª 5 ª 5 x assignment coordinates in the high resolution image (
% getSamplingInformation output)
% assignmentPositionsY - (m - 4) ª (n - 4) ª 3 ª 5 ª 5 y assignment coordinates in the high resolution image (
% getSamplingInformation output)
% samplingPositionsX - (m - 4) ª (n - 4) ª 3 ª 5 ª 5 x sampling coordinates in the rendered pyramid image (
% getSamplingInformation output)
% samplingPositionsY - (m - 4) ª (n - 4) ª 3 ª 5 ª 5 y sampling coordinates in the rendered pyramid image (
% getSamplingInformation output)
% weights - (m - 4) ª (n - 4) ª 3 matrix with the weights for each DB candidate
% emptyHighResImage - M ª N zeros image, where M and N are the dimensions of a level in the pyramid that should
% be reconstructed in this function
% renderedPyramid - a single image containing all levels of the pyramid
% Outputs:
% image - M ª N high resolution image

%size(assignmentPositionsX)
%size(samplingPositionsX)
%size(samplingPositionsY)
%size(weights)
%size(emptyHighResImage)
%size(renderedPyramid)
% creating 75 pictures
%images = [];
%for i = 1 : 5
 %   for  j = 1 : 5
  %      bestChild = max(weights(i,j, :)); % 1x1
   %     xPos = samplingPositionsX(i, j, bestChild, :, :); % 5x5
    %    yPos = samplingPositionsY(i, j, weights, :, :);   % 5x5
     %   for t = 1 : 3
      %     weightScalar = weights(i, j, bestChild); % 1x1
      %     weightMatrix = repmat(a, 5, 5);          % 5x5
           %xPos = reshape(a(size));
           %yPos = reshape(a(size));
           
       %    emptyHighResImage() = interp2(emptyHighResImage ,x , y, 'cubic');
       %    numinator = numinator + m(t, i, j) * weights(t, i, j);
       %    denuminator = denuminator + weights(t, i, j);
       % end  

      % images(t, i, j) = numinator ./ denuminator;        
    %end    
%end

image = emptyHighResImage;
%size(emptyHighResImage)
    totalWeightImage = emptyHighResImage;
    samples = interp2(renderedPyramid, samplingPositionsX, samplingPositionsY, 'cubic');
    nanMap = isnan(samples);
    weights = repmat(weights, [1,1,1,5,5]);
    samples(nanMap) = 0;
    weights(nanMap) = 0;
    
    for k=1:3
        for i=1:5
            for j=1:5
                weightsIm = emptyHighResImage;
                im = emptyHighResImage;
                
                samplesImMat = samples(1 + i : 5: end, 1  + j: 5: end, k, :, :);
                assignmentImXMat = assignmentPositionsX(1 + i: 5: end, 1 + j: 5: end, k, :, :);
                assignmentImYMat = assignmentPositionsY(1 + i: 5: end, 1 + j: 5: end, k, :, :);
                weightsMat = weights(1 + i: 5: end, 1 + j: 5: end, k, :, :);
                %size(im)
                %assignmentImYMat
                im(sub2ind(size(im), assignmentImYMat(:), assignmentImXMat(:))) =  samplesImMat(:);
                weightsIm(sub2ind(size(weightsIm), assignmentImYMat(:), assignmentImXMat(:))) =  weightsMat(:);

                totalWeightImage = totalWeightImage + weightsIm;
                image = image + (weightsIm .* im);
            end
        end
    end

    image = image ./ totalWeightImage;





end