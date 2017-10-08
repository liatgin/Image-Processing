%Blending 2 pictures: a unicorn + blue flame into flamed unicoorn.
function[] = blendingExample2()

I2=imReadAndConvert('fire.jpg', 2);
I1=imReadAndConvert('horse.jpg', 2);
Mask=imReadAndConvert('mas3.jpg', 2);

blendRGBImg = zeros(size(I1));
for j = 1:3
   blendRGBImg(:,:,j) = pyramidBlending(I1(:,:,j), I2(:,:,j), Mask(:,:,j), 6, 90, 90);
end
figure, imshow(I2);
figure, imshow(I1);
figure, imshow(Mask);
figure, imshow(blendRGBImg);
end