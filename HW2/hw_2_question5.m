% HOMEWORK 2
% BATUHAN TOSUN 2017401141

%% Question 5: COLOR IMAGE ENHANCEMENT

% reading image
img = imread("Child.jpg");

a = 0; % desired lower limit
b = 255; % desired upper limit
c_vals = zeros(1,3);
d_vals = zeros(1,3);

n_img = zeros(size(img));

for k=1:3 % for each layer
    channel = double(img(:,:,k));
    c = min(min(channel));
    d = max(max(channel));
    
    c_vals(1,k) = c;
    d_vals(1,k) = d;
    
    n_img(:,:,k) = (channel-c)*(b-a)/(d-c)+a;    
end

n_img = uint8(n_img+0.5);

figure
subplot(1,2,1)
imshow(img)
title("Original Image")
subplot(1,2,2)
imshow(n_img)
title("Enhanced Image")


%% part b: HSV Color Space

hsv_img = rgb2hsv(img);
hsv_max = max(max(hsv_img(:,:,3)));
hsv_min = min(min(hsv_img(:,:,3)));

a = 0;
b = 1;
hsv_img(:,:,3) = hsv_img(:,:,3)*(b-a)/(hsv_max-hsv_min)+a;

t_hsv_img = hsv2rgb(hsv_img);

figure
subplot(1,2,1)
imshow(img)
title("Original Image")
subplot(1,2,2)
imshow(uint8(t_hsv_img*255))
title("Enhanced Image2")




    