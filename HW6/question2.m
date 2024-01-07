% EE475 : Homework 6
% Batuhan Tosun 2017401141

%% Question 2

img = imread("Debris.tif");

% to delete the structuring element given left-bottom of the image
img(601:633,601:633)=0;

imgA = img;

B_ste = strel('disk',12);

imgC = imerode(imgA,B_ste);

imgD = imdilate(imgC,B_ste);

imgE = imdilate(imgD,B_ste);

imgF = imerode(imgE,B_ste);


subplot(2,2,1)
imshow(imgC)
title('Image C')

subplot(2,2,2)
imshow(imgD)
title('Image D')

subplot(2,2,3)
imshow(imgE)
title('Image E')

subplot(2,2,4)
imshow(imgF)
title('Image F')