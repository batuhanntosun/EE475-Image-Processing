% EE475 : Homework 6
% Batuhan Tosun 2017401141

%% Question 3: Morpho 3

figure
img = imread("headCT.tif");
subplot(2,2,1)
imshow(img)
title("Image A: Original");

% grayscale dilation
SE = strel([1,1,1;1,1,1;1,1,1]); % structuring element
imgb = imdilate(img,SE);
subplot(2,2,2)
imshow(imgb)
title("Image B: Dilation");

% grayscale eroding
imgc = imerode(imgb,SE);
subplot(2,2,3)
imshow(imgc)
title("Image C: Erosion");

% morphological gradient
imgc_er = imerode(imgc,SE);
imgc_dil = imdilate(imgc,SE);

imgd = imgc_dil-imgc_er;
subplot(2,2,4)
imshow(imgd,[])
title("Image D: Gradient");



