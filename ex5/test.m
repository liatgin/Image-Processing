function []= test()
pyr = createPyramid(imread('butterfly.png'));
[p_x1, p_y1, imPatches] = samplePatches(imread('butterfly.png'), 0);
[p_x2, p_y2, levels, dbPatches] = createDB( pyr );

%size(imPatches)
%size(dbPatches)
%imPatches = reshape(imPatches, size(imPatches,1)* size(imPatches,2), 5, 5);

%[idx,Dist] = findNearestNeighbors( imPatches, dbPatches );

end