% EE475 : Homework 6
% Batuhan Tosun 2017401141

%% Question 5

img = zeros(230,230,3);

img(21:70,21:70,1)=255;
img(21:70,91:140,2)=255;
img(21:70,161:210,3)=255;


img(91:140,21:70,1)=255;
img(91:140,21:70,3)=255;

img(91:140,91:140,2)=255;
img(91:140,91:140,3)=255;

img(91:140,161:210,1)=255;
img(91:140,161:210,2)=255;


img(161:210,91:140,1)=255;
img(161:210,91:140,2)=255;
img(161:210,91:140,3)=255;

img = uint8(img);

figure
imshow(img)
title("Original Image")
%%
hsv_img = rgb2hsv(img);
h_img = hsv_img(:,:,1);
s_img = hsv_img(:,:,2);
v_img = zeros(230,230,1);

v_img(21:70,21:70,1)=85;
v_img(21:70,91:140,1)=85;
v_img(21:70,161:210,1)=85;

v_img(91:140,21:70,1)=160;
v_img(91:140,91:140,1)=160;
v_img(91:140,161:210,1)=160;

v_img(161:210,91:140,1)=255;


figure
imshow(uint8(h_img*255))
title("Hue Channel")
figure
imshow(uint8(s_img*255))
title("Saturation Channel")
figure
imshow(uint8(v_img));
title("Intensity Channel")
