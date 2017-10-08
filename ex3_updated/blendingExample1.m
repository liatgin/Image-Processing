% Blending 2 pictures: a baby in costume + Muhamad Abu Tir 
% into Abu tir inside the baby costume. 
function[] = blendingExample1()

I2=imReadAndConvert('i2.png', 2);
I1=imReadAndConvert('i1.png', 2);
Mask=imReadAndConvert('mask.png', 2);

blendRGBImg = zeros(size(I1));
for j = 1:3
   blendRGBImg(:,:,j) = pyramidBlending(I1(:,:,j), I2(:,:,j), Mask(:,:,j), 9, 100, 100);
end
figure, imshow(I2);
figure, imshow(I1);
figure, imshow(Mask);
figure, imshow(blendRGBImg);


end