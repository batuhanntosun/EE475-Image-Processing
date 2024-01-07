% EE475 : Homework 6
% Batuhan Tosun 2017401141

%% Question 4: Color 1

img = imread("Dark_stream.tif");
figure
imshow(img)
title("Original Image")

R_img = img(:,:,1);
G_img = img(:,:,2);
B_img = img(:,:,3);

[eq_R_img, T_red]  = histeq(R_img);
[eq_G_img, T_green] = histeq(G_img);
[eq_B_img, T_blue] = histeq(B_img);

img_new = zeros(size(img));
img_new(:,:,1) = eq_R_img;
img_new(:,:,2) = eq_G_img;
img_new(:,:,3) = eq_B_img;

img_new = uint8(img_new);
figure
imshow(img_new)
title("Histogram Equalized-First Method")
imwrite(img_new,"Dark_stream_histeq.tif");


%%

%b
avg_hist2 = (T_red + T_green + T_blue)./3;

new_R = avg_hist2(R_img+1);
new_G = avg_hist2(G_img+1);
new_B = avg_hist2(B_img+1);

eq_R_img3 = round(new_R.*255);
eq_G_img3 = round(new_G.*255);
eq_B_img3 = round(new_B.*255);

img_new3 = zeros(size(img));
img_new3(:,:,1) = eq_R_img3;
img_new3(:,:,2) = eq_G_img3;
img_new3(:,:,3) = eq_B_img3;

figure
imshow(uint8(img_new3))
title("Histogram Equalized-Second Method")
imwrite(img_new3,'Dark_stream_histeq3.jpg')
