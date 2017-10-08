function [ highres ] = superResolution( im )
%SUPERRESOLUTION Summary of this function goes here
%Getting an image and returns high resolution image with doubled size.
% Arguments:
% im - grayscale image
% 
% Outputs:
% highres - high resolution image

%Get the pyramid from the input image:
%im = rgb2gray(imread('butterfly.png'));
pyr = createPyramid( im );

[m,n]=size(im);

%Sample patches for the imput image:
[pxIm, pyIm, imPatches] = samplePatches( im ,0 );

reshapedImPatches=reshape(imPatches,[size(imPatches,1)*size(imPatches,2),5,5]);
[dbPx, dbPy,centersPyrLevel, dbPatches] = createDB( pyr );
%size(dbPy)  % 60775x1
[idx,Dist] = findNearestNeighbors( reshapedImPatches,dbPatches  );

%Save the positions of the center of the neighbors (child patches)
 xCenters=dbPx(idx);
 yCenters=dbPy(idx);
 centersPyrLevel=centersPyrLevel(idx);

%change the shape to be arranged like the initial sampled patches
%size(yCenters)
%m-4
%n-4 
%(m-4) * (n-4)
 yCenters=reshape(yCenters,[(m-4),(n-4),3]);
% 2
 centersPyrLevel=reshape(centersPyrLevel,[(m-4),(n-4),3]);
% 3
 xCenters=reshape(xCenters,[(m-4),(n-4),3]);
% 4

%Calculate the Std of db patches:
 dbPatches=reshape(dbPatches, [size(dbPatches,1),25]);
% 5
 stdDb= std(dbPatches,[],2);
%Avoid a situation of division by zero:
 stdDb(stdDb==0)=0.00001;
 stdDb=stdDb(idx);
 stdDb=reshape(stdDb,[(m-4),(n-4),3]);
% 6
 Dist=reshape(Dist,[(m-4),(n-4),3]);
% 7


 weights = weightsSetting( imPatches,Dist,pyr,stdDb );


%Building each empty level in the pyramid
for i=5:7
    [sampleCentersX,sampleCentersY,renderedPyramid]  = getSamplingCenters(xCenters, yCenters, centersPyrLevel,pyr,i-4  );
    [assignmentPositionsX,assignmentPositionsY,samplingPositionsX,samplingPositionsY] = getSamplingInformation(sampleCentersX,sampleCentersY,pyr,pxIm,pyIm,i-4);
    
    %Create a zeros image that has the size of the current pyramid level
    %that we build now.
    %size(pyr{i},1)
    %size(pyr{i},2)
    emptyHighResImage=zeros(size(pyr{i},1),size(pyr{i},2));
    
    highres = getImage(assignmentPositionsX,assignmentPositionsY,samplingPositionsX,samplingPositionsY,weights,emptyHighResImage,renderedPyramid);
    %highres = imsharpen(highres);
    pyr{i}=highres;
end



end

