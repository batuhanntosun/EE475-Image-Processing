% HOMEWORK 2
% BATUHAN TOSUN 2017401141

%% Question 2 : Intensity Transformations

img = imread("Fractured spine.jpg");

%% a: log transformation

c1 = 50;
log_img = c1*log(1+double(img));

figure
subplot(1,3,1)
imshow(img)
title("Original Image")
subplot(1,3,2)
imshow(uint8(log_img))
title("Log Transform with c="+c1);

% b: power-law transformation
c2 = 40;
gama = 0.4;
power_img = c2*(double(img).^gama);
subplot(1,3,3)
imshow(uint8(power_img))
title("Power-law Transform with c="+c2+" and gama="+gama);

