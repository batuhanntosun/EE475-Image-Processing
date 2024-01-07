% Homework 1
% Batuhan Tosun 2017401141

%% question 5 : Image Bit Slicing

img = imread("lena.bmp");

[M,N] = size(img);

most_img = zeros(M,N);
least_img = zeros(M,N);

for i=1:M
    for j=1:N
        Y = dec2bin(img(i,j),8);
        most_img(i,j) = str2num(Y(1));
        least_img(i,j) = str2num(Y(end));
    end
end

most_img = 255*most_img;
least_img = 255*least_img;

figure
subplot(1,3,1)
imshow(img)
title("Original Image")
subplot(1,3,2)
imshow(most_img)
title("MSB Binary Image")
subplot(1,3,3)
imshow(least_img)
title("LSB Binary Image")

